output "grep_exclude" {
  value = local.grep_excludes != null ? "grep -vE '${local.grep_excludes}'" : null
}

output "grep_include" {
  value = local.grep_includes != null ? local.grep_includes : null
}
