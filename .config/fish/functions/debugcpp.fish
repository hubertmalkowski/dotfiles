function debugcpp --wraps='codelldb --port 13000' --description 'alias debugcpp codelldb --port 13000'
  codelldb --port 13000 $argv
        
end
