variable "enabled" {
  type        = bool
  default     = true
  description = "是否开启全局部署"
}

variable "run_trigger" {
  type        = string
  default     = "filemd5"
  description = "always 则一直运行，filemd5 当引用文件发生变化时运行"
}
