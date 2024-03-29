output "grep_command" {
  value = "grep -vE  '${local.grep_excludes}' 1.txt"
}
