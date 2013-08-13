require 'test_helper'

class ParseCreateTableTest < Test::Unit::TestCase

  def test_create_acii_table
    create_table_code = <<-EOF
      class CreateStartupPhotos < ActiveRecord::Migration
        def change
          create_table :startup_photos do |t|
            t.string  :photo  # hello
            t.integer :startup_id
            t.timestamps
          end

          add_index :startup_photos, :startup_id
        end
      end
      EOF

    res = Description::ParseCreateTable text: create_table_code
    puts res

    sexp = RubyParser.new.parse(create_table_code)
    puts sexp.inspect

    results = sexp / Q?{ s(:call, nil, :create_table, s(:lit, atom % 'table_name')) }

    #puts path

    puts results.inspect

    results.each do |sexp_result|
      puts sexp_result.inspect
      table_name = sexp_result['table_name']
      puts table_name
    end
      
  end
    
end
