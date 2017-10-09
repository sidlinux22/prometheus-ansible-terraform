output "compute_ip" {
    value = "${join(",", aws_instance.web.*.ip)}"
}