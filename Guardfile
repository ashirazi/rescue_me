# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard :test do
  watch(%r{^lib/(.+)\.rb$})     { |m| "test/test_#{m[1]}.rb" }
  watch(%r{^test/test_.+\.rb$})
  watch('test/helper.rb')  { "test" }
end
