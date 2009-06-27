HTTPRequest.make "http://google.com"

FS::File.touch "/tmp/foo.txt" do
  mode 0700
end

RackApp.deploy "twitter" do
  hostname "twitter.local"
end
