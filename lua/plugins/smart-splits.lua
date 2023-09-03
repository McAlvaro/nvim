return {
  "mrjones2014/smart-splits.nvim",
  config = true,
  keys = {
    {
      "<Leader><Left>",
      function()
        require("smart-splits").resize_left()
      end,
      desc = "Resize window left +10",
    },
    {
      "<Leader><Down>",
      function()
        require("smart-splits").resize_down()
      end,
      desc = "Resize window down +10",
    },
    {
      "<Leader><Up>",
      function()
        require("smart-splits").resize_up()
      end,
      desc = "Resize window up +10",
    },
    {
      "<Leader><Right>",
      function()
        require("smart-splits").resize_right()
      end,
      desc = "Resize window right +10",
    },
  },
}

