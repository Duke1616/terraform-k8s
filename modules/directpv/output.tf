output "grep_command" {
  value = local.grep_excludes != null ? "grep -vE '${local.grep_excludes}' 1.txt" : null
}
