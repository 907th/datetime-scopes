def create_tmp_model(columns = {}, &block)
  time = Time.now.to_f.to_s.gsub(".", "_")
  model_name = "TmpClass#{time}"
  table_name = "tmp_class#{time}s"

  begin
    Object.send :remove_const, model_name
  rescue NameError
  end

  ActiveRecord::Migration.create_table table_name do |t|
    columns.each do |name, type|
      t.column name, type
    end
  end

  Object.class_eval <<-EOS
    class #{model_name} < ActiveRecord::Base
      self.table_name = "#{table_name}"
    end
  EOS

  klass = Object.const_get(model_name)
  klass.class_exec &block if block_given?
  klass
end
