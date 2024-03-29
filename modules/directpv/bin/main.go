package main

import (
	"bufio"
	"fmt"
	"io/ioutil"
	"os"
	"strings"

	"github.com/spf13/cobra"
	"gopkg.in/yaml.v3"
)

type Drive struct {
	ID    string `yaml:"id"`
	Name  string `yaml:"name"`
	Size  string `yaml:"size"`
	Make  string `yaml:"make"`
	Select string `yaml:"select"`
}

type Node struct {
	Name   string  `yaml:"name"`
	Drives []Drive `yaml:"drives"`
}

type Config struct {
	Version string `yaml:"version"`
	Nodes   []Node `yaml:"nodes"`
}

var (
	directPvPath string
	initDiskPath string
	newInitDiskFile string
)

var rootCmd = &cobra.Command{
	Use:   "DirectPv",
	Short: "Init Disk",
	Long:  "利用Terraform执行DirectPv进行磁盘初始化",
	Run: func(cmd *cobra.Command, args []string) {
		modify, err := readDiskInit()
		if err != nil {
			return
		}

		writeNewDirectYaml(modify)
	},
}

func main() {
	err := rootCmd.Execute()
	cobra.CheckErr(err)
}

func writeNewDirectYaml(dataMap map[string][]string) {
	// 读取 YAML 文件内容
	yamlFile, err := ioutil.ReadFile(directPvPath)
	if err != nil {
		fmt.Println("无法读取 YAML 文件:", err)
		return
	}

	// 解析 YAML 文件内容到 Config 结构体
	var config Config
	err = yaml.Unmarshal(yamlFile, &config)
	if err != nil {
		fmt.Println("无法解析 YAML 文件:", err)
		return
	}

	// 创建一个新的 Config 结构体，用于存储保留的节点信息
	var newConfig Config
	newConfig.Version = config.Version

	// 遍历原始的节点信息
	for _, node := range config.Nodes {
		// 检查当前节点是否在目标数据结构中
		if drives, ok := dataMap[node.Name]; ok {
			var newDrives []Drive
			// 遍历当前节点的磁盘信息
			for _, drive := range node.Drives {
				// 检查当前磁盘是否在目标磁盘列表中
				if contains(drives, drive.Name) {
					newDrives = append(newDrives, drive)
				}
			}
			// 更新当前节点的磁盘信息
			node.Drives = newDrives
			// 将更新后的节点添加到新的配置中
			newConfig.Nodes = append(newConfig.Nodes, node)
		}
	}

	// 将新的 Config 结构体转换为 YAML 格式，并输出到文件中
	newYamlContent, err := yaml.Marshal(&newConfig)
	if err != nil {
		fmt.Println("无法转换为 YAML 格式:", err)
		return
	}

	err = ioutil.WriteFile(newInitDiskFile, newYamlContent, 0644)
	if err != nil {
		fmt.Println("无法写入文件:", err)
		return
	}

	fmt.Println("YAML 文件已更新")
}


// contains 函数用于检查切片中是否包含某个元素
func contains(s []string, e string) bool {
	for _, a := range s {
		if a == e {
			return true
		}
	}
	return false
}

func readDiskInit() (map[string][]string, error) {
	// 打开文件
	file, err := os.Open(initDiskPath)
	if err != nil {
		fmt.Println("无法打开文件:", err)
		return nil, err
	}
	defer file.Close()

	// 创建 map 用于存储节点的磁盘信息
	nodeDisks := make(map[string][]string)

	// 创建一个 Scanner 来读取文件内容
	scanner := bufio.NewScanner(file)

	// 逐行读取文件内容
	for scanner.Scan() {
		// 当前行内容
		line := scanner.Text()

		// 使用空格拆分每行内容，得到字段
		fields := strings.Fields(line)

		// 提取节点和磁盘信息
		node := fields[1]
		disk := fields[2]

		// 存储数据
		nodeDisks[node] = append(nodeDisks[node], disk)
	}

	// 检查 Scanner 是否出错
	if err = scanner.Err(); err != nil {
		fmt.Println("读取文件时发生错误:", err)
	}

	return nodeDisks, nil
}

func init() {
	rootCmd.PersistentFlags().StringVarP(&directPvPath, "direct-path", "d", "diretpv.yaml", "所有磁盘格式化生成文件")
	rootCmd.PersistentFlags().StringVarP(&initDiskPath, "init-disk-path", "i", "init-disk.txt", "需要格式化的磁盘信息")
	rootCmd.PersistentFlags().StringVarP(&newInitDiskFile, "new-file-path", "f", "new-diretpv.txt", "过滤后文件存放位置")
}
