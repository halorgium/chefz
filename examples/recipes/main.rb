make HTTPRequest, "http://google.com"

touch FS::File, "/tmp/foo.txt" do
  mode 0700
end

deploy RackApp, "twitter" do
  hostname "twitter.local"
end
