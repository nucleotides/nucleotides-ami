deps       := ami.json $(shell find provision -type f)
image-name := nucleotides-evaluation-$(shell date +%s)

credential = $(shell grep $(1) ~/.aws/credentials | cut -f 2 -d = | tr -d " ")

################################################
#
# Build and publish AMI ID
#
################################################

publish: .ami
	@./tmp/s3cmd/s3cmd \
		--access_key=$(call credential,access_key_id) \
		--secret_key=$(call credential,secret) \
		put $< \
		s3://nucleotides-tools/ami-ids/$(shell date +%Y-%m-%d-%H:%m:%S)

build: .ami

.ami: $(deps)
	packer validate -var "image-name=$(image-name)" $<
	packer build -var "image-name=$(image-name)" $< | tee tmp/packer.log
	grep 'AMI: ami-' tmp/packer.log | cut -f 7 -d ' ' | tr -d ' ' > $@


################################################
#
# Bootstrap required project resources
#
################################################

bootstrap: tmp/nucleotides-client.zip tmp/s3cmd/s3cmd

tmp/nucleotides-client.zip:
	mkdir -p $(dir $@)
	wget \
		--quiet \
		--output-document $@ \
		https://s3-us-west-1.amazonaws.com/nucleotides-tools/client/0.x.y/nucleotides-client.zip

tmp/s3cmd/s3cmd:
	mkdir -p $(dir $@)
	wget \
		--quiet \
		--output-document - \
		https://github.com/s3tools/s3cmd/releases/download/v1.6.1/s3cmd-1.6.1.tar.gz |\
	tar xzf - \
		--directory $(dir $@) \
		--strip-components=1
