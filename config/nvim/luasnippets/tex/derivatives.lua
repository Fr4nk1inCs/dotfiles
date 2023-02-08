local snips, autosnips = {}, {}

local tex = require("helper.latex")

snips = {
    s({
        trig = "de",
        name = "Differential",
        dscr = "Insert a differential",
        docstring = "\\mathrm{d} {#1|x}",
    }, {
        t("\\mathrm{d} "),
        i(1, "x"),
    }, {
        condition = tex.in_mathzone,
        show_condition = function()
            return false
        end,
    }),
    s({
        trig = "de(%a)(%a)",
        name = "Derivative",
        dscr = "Insert a derivative",
        docsting = "\\frac{\\mathrm{d} .}{\\mathrm{d} .}",
        regTrig = true,
    }, {
        f(function(_, snip)
            return "\\frac{\\mathrm{d} " .. snip.captures[1] .. "}{\\mathrm{d} " .. snip.captures[2] .. "}"
        end, {}),
    }, {
        condition = tex.in_mathzone,
        show_condition = function()
            return false
        end,
    }),
    s({
        trig = "de(%a)(%a)(%a)",
        name = "Derivative",
        dscr = "Insert a second-order derivative",
        docsting = "\\frac{\\mathrm{d}^{2} .}{\\mathrm{d} . \\mathrm{d} .}",
        regTrig = true,
    }, {
        f(function(_, snip)
            return "\\frac{\\mathrm{d}^{2} "
                .. snip.captures[1]
                .. "}{\\mathrm{d} "
                .. snip.captures[2]
                .. " \\mathrm{d} "
                .. snip.captures[3]
                .. "}"
        end, {}),
    }, {
        condition = tex.in_mathzone,
        show_condition = function()
            return false
        end,
    }),
    s({
        trig = "de(%a)(%a)(%d)",
        name = "Derivative",
        dscr = "Insert a high-order derivative",
        docsting = "\\frac{\\mathrm{d} .}{\\mathrm{d} .}",
        regTrig = true,
    }, {
        f(function(_, snip)
            return "\\frac{\\mathrm{d}^{"
                .. snip.captures[3]
                .. "} "
                .. snip.captures[1]
                .. "}{\\mathrm{d} "
                .. snip.captures[2]
                .. "^{"
                .. snip.captures[3]
                .. "}}"
        end, {}),
    }, {
        condition = tex.in_mathzone,
        show_condition = function()
            return false
        end,
    }),
    s({
        trig = "pa",
        name = "Partial Differential",
        dscr = "Insert a partial differential",
        docstring = "\\partial {#1|x}",
    }, {
        t("\\partial "),
        i(1, "x"),
    }, {
        condition = tex.in_mathzone,
        show_condition = function()
            return false
        end,
    }),
    s({
        trig = "pa(%a)(%a)",
        name = "Partial Derivative",
        dscr = "Insert a partial derivative",
        docsting = "\\frac{\\partial .}{\\partial .}",
        regTrig = true,
    }, {
        f(function(_, snip)
            return "\\frac{\\partial " .. snip.captures[1] .. "}{\\partial " .. snip.captures[2] .. "}"
        end, {}),
    }, {
        condition = tex.in_mathzone,
        show_condition = function()
            return false
        end,
    }),
    s({
        trig = "pa(%a)(%a)(%a)",
        name = "Partial Derivative",
        dscr = "Insert a second-order partial derivative",
        docsting = "\\frac{\\partial^{2} .}{\\partial . \\partial .}",
        regTrig = true,
    }, {
        f(function(_, snip)
            return "\\frac{\\partial^{2} "
                .. snip.captures[1]
                .. "}{\\partial "
                .. snip.captures[2]
                .. " \\partial "
                .. snip.captures[3]
                .. "}"
        end, {}),
    }, {
        condition = tex.in_mathzone,
        show_condition = function()
            return false
        end,
    }),
    s({
        trig = "pa(%a)(%a)(%d)",
        name = "Partial Derivative",
        dscr = "Insert a high-order partial derivative",
        docsting = "\\frac{\\partial .}{\\partial .}",
        regTrig = true,
    }, {
        f(function(_, snip)
            return "\\frac{\\partial^{"
                .. snip.captures[3]
                .. "} "
                .. snip.captures[1]
                .. "}{\\partial "
                .. snip.captures[2]
                .. "^{"
                .. snip.captures[3]
                .. "}}"
        end, {}),
    }, {
        condition = tex.in_mathzone,
        show_condition = function()
            return false
        end,
    }),
}

autosnips = {
    s({
        trig = "der",
        name = "Insert a derivative",
    }, {
        c(1, {
            fmt("\\frac{{ \\mathrm{{d}} {} }}{{ \\mathrm{{d}} {} }} ", { i(1), i(2) }),
            fmt("\\dfrac{{ \\mathrm{{d}} {} }}{{ \\mathrm{{d}} {} }} ", { i(1), i(2) }),
        }),
    }, {
        condition = tex.in_mathzone,
    }),
    s({
        trig = "de2",
        name = "Insert a second-order derivative",
    }, {
        c(1, {
            fmt("\\frac{{ \\mathrm{{d}}^{{2}} {} }}{{ \\mathrm{{d}} {{{}}}^{{2}} }} ", { i(1), i(2) }),
            fmt("\\frac{{ \\mathrm{{d}}^{{2}} {} }}{{ \\mathrm{{d}} {} \\mathrm{{d}} {} }} ", { i(1), i(2), i(3) }),
            fmt("\\dfrac{{ \\mathrm{{d}}^{{2}} {} }}{{ \\mathrm{{d}} {{{}}}^{{2}} }} ", { i(1), i(2) }),
            fmt("\\dfrac{{ \\mathrm{{d}}^{{2}} {} }}{{ \\mathrm{{d}} {} \\mathrm{{d}} {} }} ", { i(1), i(2), i(3) }),
        }),
    }, {
        condition = tex.in_mathzone,
    }),
    s({
        trig = "de3",
        name = "Insert a third-order derivative",
    }, {
        c(1, {
            fmt("\\frac{{ \\mathrm{{d}}^{{3}} {} }}{{ \\mathrm{{d}} {{{}}}^{{3}} }} ", { i(1), i(2) }),
            fmt(
                "\\frac{{ \\mathrm{{d}}^{{3}} {} }}{{ \\mathrm{{d}}^{{2}} {} \\mathrm{{d}} {} }} ",
                { i(1), i(2), i(3) }
            ),
            fmt(
                "\\frac{{ \\mathrm{{d}}^{{3}} {} }}{{ \\mathrm{{d}} {} \\mathrm{{d}}^{{2}} {} }} ",
                { i(1), i(2), i(3) }
            ),
            fmt(
                "\\frac{{ \\mathrm{{d}}^{{3}} {} }}{{ \\mathrm{{d}} {} \\mathrm{{d}} {} \\mathrm{{d}} {} }} ",
                { i(1), i(2), i(3), i(4) }
            ),
            fmt("\\dfrac{{ \\mathrm{{d}}^{{3}} {} }}{{ \\mathrm{{d}} {{{}}}^{{3}} }} ", { i(1), i(2) }),
            fmt(
                "\\dfrac{{ \\mathrm{{d}}^{{3}} {} }}{{ \\mathrm{{d}}^{{2}} {} \\mathrm{{d}} {} }} ",
                { i(1), i(2), i(3) }
            ),
            fmt(
                "\\dfrac{{ \\mathrm{{d}}^{{3}} {} }}{{ \\mathrm{{d}} {} \\mathrm{{d}}^{{2}} {} }} ",
                { i(1), i(2), i(3) }
            ),
            fmt(
                "\\dfrac{{ \\mathrm{{d}}^{{3}} {} }}{{ \\mathrm{{d}} {} \\mathrm{{d}} {} \\mathrm{{d}} {} }} ",
                { i(1), i(2), i(3), i(4) }
            ),
        }),
    }, {
        condition = tex.in_mathzone,
    }),
    s({
        trig = "ddt",
        name = "Insert a d/dt",
    }, {
        c(1, {
            t("\\frac{\\mathrm{d}}{\\mathrm{d}t}"),
            t("\\dfrac{\\mathrm{d}}{\\mathrm{d}t}"),
        }),
    }, {
        condition = tex.in_mathzone,
    }),
    s({
        trig = "par",
        name = "Insert a partial derivatives",
    }, {
        c(1, {
            fmt("\\frac{{ \\partial {} }}{{ \\partial {} }} ", { i(1), i(2) }),
            fmt("\\dfrac{{ \\partial {} }}{{ \\partial {} }} ", { i(1), i(2) }),
        }),
    }, {
        condition = tex.in_mathzone,
    }),
    s({
        trig = "pa2",
        name = "Insert a second-order partial derivatives",
    }, {
        c(1, {
            fmt("\\frac{{ \\partial^{{2}} {} }}{{ \\partial {{{}}}^{{2}} }} ", { i(1), i(2) }),
            fmt("\\frac{{ \\partial^{{2}} {} }}{{ \\partial {} \\partial {} }} ", { i(1), i(2), i(3) }),
            fmt("\\dfrac{{ \\partial^{{2}} {} }}{{ \\partial {{{}}}^{{2}} }} ", { i(1), i(2) }),
            fmt("\\dfrac{{ \\partial^{{2}} {} }}{{ \\partial {} \\partial {} }} ", { i(1), i(2), i(3) }),
        }),
    }, {
        condition = tex.in_mathzone,
    }),
    s({
        trig = "pa3",
        name = "Insert a third-order partial derivatives",
    }, {
        c(1, {
            fmt("\\frac{{ \\partial^{{3}} {} }}{{ \\partial {{{}}}^{{3}} }} ", { i(1), i(2) }),
            fmt("\\frac{{ \\partial^{{3}} {} }}{{ \\partial^{{2}} {} \\partial {} }} ", { i(1), i(2), i(3) }),
            fmt("\\frac{{ \\partial^{{3}} {} }}{{ \\partial {} \\partial^{{2}} {} }} ", { i(1), i(2), i(3) }),
            fmt(
                "\\frac{{ \\partial^{{3}} {} }}{{ \\partial {} \\partial {} \\partial {} }} ",
                { i(1), i(2), i(3), i(4) }
            ),
            fmt("\\dfrac{{ \\partial^{{3}} {} }}{{ \\partial {{{}}}^{{3}} }} ", { i(1), i(2) }),
            fmt("\\dfrac{{ \\partial^{{3}} {} }}{{ \\partial^{{2}} {} \\partial {} }} ", { i(1), i(2), i(3) }),
            fmt("\\dfrac{{ \\partial^{{3}} {} }}{{ \\partial {} \\partial^{{2}} {} }} ", { i(1), i(2), i(3) }),
            fmt(
                "\\dfrac{{ \\partial^{{3}} {} }}{{ \\partial {} \\partial {} \\partial {} }} ",
                { i(1), i(2), i(3), i(4) }
            ),
        }),
    }, {
        condition = tex.in_mathzone,
    }),
}

return snips, autosnips
