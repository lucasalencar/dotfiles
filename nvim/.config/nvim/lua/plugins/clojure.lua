return {
  {
    -- Clojure REPL integration
    'Olical/conjure',
    ft = 'clojure',
    config = function()
      -- Set mapping to run current test under cursor
      vim.g["conjure#client#clojure#nrepl#mapping#run_current_test"] = 'tt'

      -- Configure forms that are identified as tests
      vim.g["conjure#client#clojure#nrepl#test#current_form_names"] = { 'deftest', 'defspec', 'defflow' }
    end
  }
}
