def build_template(template_name)
  template = File.read("#{template_root}/#{template_name}")
  ERB.new(template).result(binding)
end