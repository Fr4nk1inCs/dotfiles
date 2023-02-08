local snips, autosnips = {}, {}

local tex = require("helper.latex")

snips = {
    s({
        trig = "arr",
        name = "array",
        dscr = "An array of numbers, index increasing, separated by \\#3",
        docstring = "#1_{#2|1}{#3|,} #1_{#4|2}#3 \\ldots, #1_{#5|n}",
    }, {
        i(1),
        t({ "_{" }),
        i(2, "1"),
        t({ "}" }),
        i(3, ","),
        t({ " " }),
        rep(1),
        t({ "_{" }),
        i(4, "2"),
        t({ "}" }),
        rep(3),
        t({ " \\ldots" }),
        rep(3),
        t({ " " }),
        rep(1),
        t({ "_{" }),
        i(5, "n"),
        t({ "}" }),
    }, {
        condition = tex.in_mathzone,
        show_condition = function()
            return false
        end,
    }),
    s({
        trig = "arr,",
        name = "array",
        dscr = "An array of numbers, index increasing, separated by commas",
        docstring = "#1_{#2|1}, #1_{#3|2}, \\ldots, #1_{#4|n}",
    }, {
        i(1),
        t({ "_{" }),
        i(2, "1"),
        t({ "}, " }),
        rep(1),
        t({ "_{" }),
        i(3, "2"),
        t({ "}, \\ldots, " }),
        rep(1),
        t({ "_{" }),
        i(4, "n"),
        t({ "}" }),
    }, {
        condition = tex.in_mathzone,
        show_condition = function()
            return false
        end,
    }),
    s({
        trig = "arr;",
        name = "array",
        dscr = "An array of numbers, index increasing, separated by semicolons",
        docstring = "#1_{1}; #1_{2}; \\ldots; #1_{#2|n}",
    }, {
        i(1),
        t({ "_{1}; " }),
        rep(1),
        t({ "_{2}; \\ldots; " }),
        rep(1),
        t({ "_{" }),
        i(2, "n"),
        t({ "}" }),
    }, {
        condition = tex.in_mathzone,
        show_condition = function()
            return false
        end,
    }),
    s({
        trig = "arr(",
        name = "array",
        dscr = "An array of numbers, index increasing, separated by commas, surrounded by left( and right)",
        docstring = "\\left(#1_{1}, #1_{2}, \\ldots, #1_{#2|n}\\right)",
    }, {
        t({ "\\left( " }),
        i(1),
        t({ "_{1}, " }),
        rep(1),
        t({ "_{2}, \\ldots, " }),
        rep(1),
        t({ "_{" }),
        i(2, "n"),
        t({ "} \\right)" }),
    }, {
        condition = tex.in_mathzone,
        show_condition = function()
            return false
        end,
    }),
    s({
        trig = "arr[",
        name = "array",
        dscr = "An array of numbers, index increasing, separated by commas, surrounded by left[ and right]",
        docstring = "\\left[#1_{1}, #1_{2}, \\ldots, #1_{#2|n}\\right]",
    }, {
        t({ "\\left[ " }),
        i(1),
        t({ "_{1}, " }),
        rep(1),
        t({ "_{2}, \\ldots, " }),
        rep(1),
        t({ "_{" }),
        i(2, "n"),
        t({ "} \\right]" }),
    }, {
        condition = tex.in_mathzone,
        show_condition = function()
            return false
        end,
    }),
    s({
        trig = "arrb",
        name = "array",
        dscr = "An array of numbers, index increasing, separated by commas, surrounded by left\\{ and right\\}",
        docstring = "\\left\\{#1_{1}, #1_{2}, \\ldots, #1_{#2|n}\\right\\}",
    }, {
        t({ "\\left\\{ " }),
        i(1),
        t({ "_{1}, " }),
        rep(1),
        t({ "_{2}, \\ldots, " }),
        rep(1),
        t({ "_{" }),
        i(2, "n"),
        t({ "} \\right\\}" }),
    }, {
        condition = tex.in_mathzone,
        show_condition = function()
            return false
        end,
    }),
    s({
        trig = "arr|",
        name = "array",
        dscr = "An array of numbers, index increasing, separated by commas, surrounded by left| and right|",
        docstring = "\\left\\lvert#1_{1}, #1_{2}, \\ldots, #1_{#2|n}\\right\\rvert",
    }, {
        t({ "\\left\\lvert " }),
        i(1),
        t({ "_{1}, " }),
        rep(1),
        t({ "_{2}, \\ldots, " }),
        rep(1),
        t({ "_{" }),
        i(2, "n"),
        t({ "} \\right\\rvert" }),
    }, {
        condition = tex.in_mathzone,
        show_condition = function()
            return false
        end,
    }),

    s({
        trig = "arr<",
        name = "array",
        dscr = "An array of numbers, index increasing, separated by commas, surrounded by leftangle and rightangle",
        docstring = "\\left\\langle#1_{1}, #1_{2}, \\ldots, #1_{#2|n}\\right\\rangle",
    }, {
        t({ "\\left\\langle " }),
        i(1),
        t({ "_{1}, " }),
        rep(1),
        t({ "_{2}, \\ldots, " }),
        rep(1),
        t({ "_{" }),
        i(2, "n"),
        t({ "} \\right\\rangle" }),
    }, {
        condition = tex.in_mathzone,
        show_condition = function()
            return false
        end,
    }),
}

autosnips = {
    s({ trig = "cvec", name = "column vector" }, {
        t({ "\\begin{pmatrix}", "\t" }),
        i(1, "x"),
        t("}_"),
        i(2, "1"),
        t({ "\\\\", "\\vdots \\\\", "" }),
        rep(1),
        t("_"),
        i(3, "n"),
        t({ "", "\\end{pmatrix}" }),
    }, { condition = tex.in_mathzone }),
}

return snips, autosnips
