CHAPTERS := $(sort $(wildcard chapters/*.md))
BUILD    := build
PDF      := $(BUILD)/linux-book.pdf
EPUB     := $(BUILD)/linux-book.epub

PANDOC_COMMON := --metadata-file=metadata.yaml --from=markdown

all: pdf epub

pdf: $(PDF)

epub: $(EPUB)

$(PDF): metadata.yaml keep-code-together.lua $(CHAPTERS) | $(BUILD)
	pandoc $(PANDOC_COMMON) \
		--pdf-engine=xelatex \
		--resource-path=.:chapters \
		--lua-filter=keep-code-together.lua \
		-o $@ $(CHAPTERS)

$(EPUB): metadata.yaml $(CHAPTERS) | $(BUILD)
	pandoc $(PANDOC_COMMON) \
		--resource-path=.:chapters \
		--epub-chapter-level=1 \
		-o $@ $(CHAPTERS)

$(BUILD):
	mkdir -p $(BUILD)

clean:
	rm -rf $(BUILD)

.PHONY: all pdf epub clean
