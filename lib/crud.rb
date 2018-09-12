require 'bigdecimal'
require 'bigdecimal/util'

module Crud

  def load(filepath)
      csv_objects = CSV.read(filepath, headers: true, header_converters: :symbol)
  end

  def find_by_id(num)
    @collection.find do |element|
      element.id == num
    end
  end

  def find_by_name(name)
    collection.find do |element|
      (element.name).downcase == name.downcase
    end
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def find_all_by_exact(key, string)
    collection.keep_if do |element|
      element[key] == string
    end
  end

  def find_all_by(type, string)
    collection.keep_if do |element|
      element.send(type).downcase.include? string.downcase
    end
  end

  def delete(id)
    collection.delete_if { |element| element.id == id }
  end

  def update(id, key_value_array)
    it = collection.find { |element| element.id == id}

    key_value_array.map do |key_value|
      if @changeable_attributes.include?(key_value[0])
       it[key_value[0]] = key_value[1]
       it.updated_at = Time.now
      end
    end
  end

end
