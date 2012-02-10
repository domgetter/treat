# This module keeps track of all the Treat::Categorizable 
# modules that exist and the methods they define.
#
#
# - Processors perform the building of tree of 
#   entities representing texts (chunking, 
#   segmenting, tokenizing, parsing).
# - Lexicalizers give lexical information about 
#   words (synsets, semantic relationships, 
#   tag, word category).
# - Extractors extract semantic information about 
#   an entity (language, topic, date, time, named 
#   entity, coreferences).
# - Inflectors allow to retrieve the different 
#   inflections of a word (declensors, conjugators, 
#   stemmers, lemmatizers).
# - Formatters handle the conversion of entities to 
#   and from different formats(readers, serializers, 
#   unserializers, visualizers).
# - Retrievers allow to index and search collections 
#   of documents.
module Treat::Categories
  
  class << self
    # A list of all categories.
    attr_accessor :list
  end
  
  # Array - list of all categories.
  self.list = []
  # A lookup table for entity types.
  @@lookup = {}
  
  # Require all categories.
  require 'treat/categorizable'
  require 'treat/formatters'
  require 'treat/processors'
  require 'treat/lexicalizers'
  require 'treat/inflectors'
  require 'treat/extractors'
  require 'treat/retrievers'
  
  # Create the lookup table.
  self.list.each do |category|
    category.groups.each do |group|
      group = category.const_get(group)
      @@lookup[group.method] = group
      group.presets.each do |x,y|
        @@lookup[x] = group
      end
    end
  end
  
  # Find the class of a group given its method.
  def self.lookup(method)
    @@lookup[method]
  end
  
end
