class RailifyTheDatabase < ActiveRecord::Migration

  def railify opts, *tables
    tables.map(&:to_s).each do |table|
      rename_table table, table.pluralize

      if opts[:id]
        rename_column table.pluralize, :"#{table}_id", :id
      end

      if opts[:last_update]
        rename_column table.pluralize, :last_update, :updated_at
      else
        add_column table.pluralize, :updated_at, :datetime, null: false, default: "NOW()"
        add_index table.pluralize, :updated_at
      end

      add_column table.pluralize, :created_at, :datetime, null: false, default: "NOW()"
      add_index table.pluralize, :created_at
    end
  end

  def change
    railify({id: true, last_update: true}, *%w(actor address category city country customer film
      inventory language  rental staff store ))
    railify({id: false, last_update: true}, *%w(film_actor film_category))
    railify({id: false, last_update: false}, *%w( payment_p2007_01 payment_p2007_02
      payment_p2007_03 payment_p2007_04 payment_p2007_05 payment_p2007_06 ))
    railify({id: true, last_update: false}, :payment)
  end
end
