#!/usr/bin/env ruby
require "nokogiri"

# Writes a black and white version of SVGs infile SVG to the outfile.
#
# Why? B&W printers do a terrible job rendering gradients in SVG. This
# script results in files that are much more legible when printed in B&W.
#
# This script reads the `infile` SVG, removes any background colors (url refs
# to linear gradients) and writes black & white versions of the SVGs to the
# `outfile` filename.
#
# Limitations: This script has only been tested with SVGs produced by the
# Yaoqiang BPMN editor. It will not work (completely) with arbitrary SVG files.

def process(doc)
  doc.css('[fill^="url(#"]').attr("fill", "#ffffff")
  doc.css('[style*="fill:url(#"]').each do |el|
    style = el.attribute("style").to_s
    updated_style = style.gsub(/fill:url\([^\)]*\)/, "fill:#ffffff")
    el["style"] = updated_style
  end
end

def svg2bw(infile, outfile)
  svg = Nokogiri::XML(File.open(infile))
  process(svg)
  svg.css("svg").each { |svg| process(svg.document) }

  File.open(outfile, "w") { |f| f.write(svg) }
end


