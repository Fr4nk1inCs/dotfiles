local snips, autosnips = {}, {}

local tex = require("helper.latex")

autosnips = {
    -- Trigonometric functions
    s({
        trig = "\\?(sinh?)%s*([^h%s])",
        name = "sin function",
        regTrig = true,
        priority = 500,
    }, {
        f(function(_, snip)
            return "\\" .. snip.captures[1] .. " " .. snip.captures[2]
        end, {}),
    }, {
        condition = tex.in_mathzone,
    }),
    s({
        trig = "\\?(arcsinh?)%s*([^h%s])",
        name = "arcsin function",
        regTrig = true,
        priority = 1000,
    }, {
        f(function(_, snip)
            return "\\" .. snip.captures[1] .. " " .. snip.captures[2]
        end, {}),
    }, {
        condition = tex.in_mathzone,
    }),
    s({
        trig = "\\?(cosh?)%s*([^h%s])",
        name = "sin function",
        regTrig = true,
        priority = 500,
    }, {
        f(function(_, snip)
            return "\\" .. snip.captures[1] .. " " .. snip.captures[2]
        end, {}),
    }, {
        condition = tex.in_mathzone,
    }),
    s({
        trig = "\\?(arccosh?)%s*([^h%s])",
        name = "arcsin function",
        regTrig = true,
        priority = 1000,
    }, {
        f(function(_, snip)
            return "\\" .. snip.captures[1] .. " " .. snip.captures[2]
        end, {}),
    }, {
        condition = tex.in_mathzone,
    }),
    s({
        trig = "\\?(tanh?)%s*([^h%s])",
        name = "sin function",
        regTrig = true,
        priority = 500,
    }, {
        f(function(_, snip)
            return "\\" .. snip.captures[1] .. " " .. snip.captures[2]
        end, {}),
    }, {
        condition = tex.in_mathzone,
    }),
    s({
        trig = "\\?(arctanh?)%s*([^h%s])",
        name = "arcsin function",
        regTrig = true,
        priority = 1000,
    }, {
        f(function(_, snip)
            return "\\" .. snip.captures[1] .. " " .. snip.captures[2]
        end, {}),
    }, {
        condition = tex.in_mathzone,
    }),
    s({
        trig = "\\?(coth?)%s*([^h%s])",
        name = "sin function",
        regTrig = true,
        priority = 500,
    }, {
        f(function(_, snip)
            return "\\" .. snip.captures[1] .. " " .. snip.captures[2]
        end, {}),
    }, {
        condition = tex.in_mathzone,
    }),
    s({
        trig = "\\?(sech?)%s*([^h%s])",
        name = "sin function",
        regTrig = true,
        priority = 500,
    }, {
        f(function(_, snip)
            return "\\" .. snip.captures[1] .. " " .. snip.captures[2]
        end, {}),
    }, {
        condition = tex.in_mathzone,
    }),
    s({
        trig = "\\?(csch?)%s*([^h%s])",
        name = "sin function",
        regTrig = true,
        priority = 500,
    }, {
        f(function(_, snip)
            return "\\" .. snip.captures[1] .. " " .. snip.captures[2]
        end, {}),
    }, {
        condition = tex.in_mathzone,
    }),
    -- Matrix functions
    s({
        trig = "\\?trans",
        name = "transverse",
        regTrig = true,
    }, {
        t("{"),
        i(1),
        t("}^{\\mathrm{T}}"),
    }, {
        condition = tex.in_mathzone,
    }),
    s({
        trig = "\\?det",
        name = "determinant",
        regTrig = true,
    }, {
        t("\\det "),
    }, {
        condition = tex.in_mathzone,
    }),
    s({
        trig = "\\?dim",
        name = "dimension",
        regTrig = true,
    }, {
        t("\\dim "),
    }, {
        condition = tex.in_mathzone,
    }),
    s({
        trig = "\\trace",
        name = "trace",
    }, {
        t("\\operatorname{Tr} "),
    }, {
        condition = tex.in_mathzone,
    }),
    s({
        trig = "\\rank",
        name = "rank",
    }, {
        t("\\operatorname{rank} "),
    }, {
        condition = tex.in_mathzone,
    }),
    -- Large operation annotations
    s({
        trig = "\\?sum",
        name = "sum",
        regTrig = true,
    }, {
        t("\\sum"),
        c(1, {
            sn(nil, { t("_{"), i(1), t("}^{"), i(2), t("}") }),
            sn(nil, { t("_{"), i(1), t("}") }),
            t(" "),
        }),
    }),
    s({
        trig = "\\?prod",
        name = "product",
        regTrig = true,
        priority = 500,
    }, {
        t("\\prod"),
        c(1, {
            sn(nil, { t("_{"), i(1), t("}^{"), i(2), t("}") }),
            sn(nil, { t("_{"), i(1), t("}") }),
            t(" "),
        }),
    }),
    s({
        trig = "\\?coprod",
        name = "coproduct",
        regTrig = true,
    }, {
        t("\\coprod"),
        c(1, {
            sn(nil, { t("_{"), i(1), t("}^{"), i(2), t("}") }),
            sn(nil, { t("_{"), i(1), t("}") }),
            t(" "),
        }),
    }),
    s({
        trig = "\\?lim",
        name = "limit",
        regTrig = true,
    }, {
        t("\\lim_{"),
        i(1, "x"),
        t("\\to "),
        i(2, "\\infty"),
        t("} "),
    }, {
        condition = tex.in_mathzone,
    }),
    -- define new function
    s({
        trig = "newop",
        name = "new operator",
    }, {
        t("\\operatorname{"),
        i(1),
        t("} "),
    }, {
        condition = tex.in_mathzone,
    }),
}

return snips, autosnips
