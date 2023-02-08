local snips, autosnips = {}, {}

local tex = require("helper.latex")

autosnips = {
    -- subscripts and superscripts
    s({
        trig = "([^\\])%^",
        name = "superscript",
        regTrig = true,
        wordTrig = false,
    }, {
        f(function(_, snip)
            return snip.captures[1]
        end, {}),
        t({ "^{" }),
        i(1),
        t({ "}" }),
    }, {
        condition = tex.in_mathzone,
    }),
    s({
        trig = "([^\\])%_",
        name = "subscript",
        regTrig = true,
        wordTrig = false,
    }, {
        f(function(_, snip)
            return snip.captures[1]
        end, {}),
        t({ "_{" }),
        i(1),
        t({ "}" }),
    }, {
        condition = tex.in_mathzone,
    }),
    s({
        trig = "sr",
        name = "square",
    }, {
        t({ "^{2}" }),
    }, {
        condition = tex.in_mathzone,
    }),
    s({
        trig = "cb",
        name = "cubic",
    }, {
        t({ "^{3}" }),
    }, {
        condition = tex.in_mathzone,
    }),
    s({
        trig = "invs",
        name = "inverse",
    }, {
        t("^{-1}"),
    }, {
        condition = tex.in_mathzone,
    }),
    s({
        trig = "rd",
        name = "power",
    }, {
        t({ "^{" }),
        i(1),
        t({ "}" }),
    }, {
        condition = tex.in_mathzone,
    }),
    -- overline and underline
    s({
        trig = "([\\%w{}%_%^]+) bar",
        name = "overline",
        regTrig = true,
    }, {
        t({ "\\overline{" }),
        f(function(_, snip)
            return snip.captures[1]
        end, {}),
        t({ "}" }),
    }, {
        condition = tex.in_mathzone,
    }),
    s({
        trig = "([\\%w{}%_%^]+) hat",
        name = "hat",
        regTrig = true,
    }, {
        t({ "\\hat{" }),
        f(function(_, snip)
            return snip.captures[1]
        end, {}),
        t({ "}" }),
    }, {
        condition = tex.in_mathzone,
    }),
    -- square root
    s({
        trig = "sq",
        name = "square root",
    }, {
        t({ "\\sqrt{" }),
        i(1),
        t({ "}" }),
    }, {
        condition = tex.in_mathzone,
    }),
    -- exponents
    s({
        trig = "([^\\])exp",
        name = "natural exponent",
        regTrig = true,
    }, {
        f(function(_, snip)
            return snip.captures[1]
        end, {}),
        t({ "\\mathrm{e}^{" }),
        i(1),
        t({ "}" }),
    }, {
        condition = tex.in_mathzone,
    }),
    -- math styles
    s({
        trig = "rm",
        name = "mathrm",
    }, {
        t({ "\\mathrm{" }),
        i(1),
        t({ "}" }),
    }, {
        condition = tex.in_mathzone,
    }),
    s({
        trig = "bf",
        name = "mathbf",
    }, {
        t({ "\\mathbf{" }),
        i(1),
        t({ "}" }),
    }, {
        condition = tex.in_mathzone,
    }),
    s({
        trig = "bs",
        name = "boldsymbol",
    }, {
        t({ "\\boldsymbol{" }),
        i(1),
        t({ "}" }),
    }, {
        condition = tex.in_mathzone,
    }),
    s({
        trig = "mcal",
        name = "mathcal",
    }, {
        t({ "\\mathcal{" }),
        i(1),
        t({ "}" }),
    }, {
        condition = tex.in_mathzone,
    }),
    s({
        trig = "mbb",
        name = "mathbb",
    }, {
        t({ "\\mathbb{" }),
        i(1),
        t({ "}" }),
    }, {
        condition = tex.in_mathzone,
    }),

    s({
        trig = "\\?bar",
        name = "overline",
        regTrig = true,
        priority = 500,
    }, {
        c(1, {
            sn(nil, { t("\\overline{"), i(1), t("}") }),
            sn(nil, { t("\\bar{"), i(1), t("}") }),
        }),
    }, {
        condition = tex.in_mathzone,
    }),
    s({
        trig = "\\?hat",
        name = "hat",
        regTrig = true,
        priority = 500,
    }, {
        t("\\hat{"),
        i(1),
        t("}"),
    }, {
        condition = tex.in_mathzone,
    }),
    -- Fractions
    s({
        trig = "\\?frac",
        name = "fraction",
        regTrig = true,
        priority = 500,
    }, {
        c(1, {
            sn(nil, { t("\\frac{ "), i(1), t(" }{ "), i(2), t(" }") }),
            sn(nil, { t("\\dfrac{ "), i(1), t(" }{ "), i(2), t(" }") }),
        }),
    }, {
        condition = tex.in_mathzone,
    }),
    s({
        trig = "\\?dfrac",
        name = "display fraction",
        regTrig = true,
    }, {
        t("\\dfrac{ "),
        i(1),
        t(" }{ "),
        i(2),
        t(" }"),
    }, {
        condition = tex.in_mathzone,
    }),
    s({
        trig = "//",
        name = "fraction",
    }, {
        c(1, {
            sn(nil, { t("\\frac{ "), i(1), t(" }{ "), i(2), t(" }") }),
            sn(nil, { t("\\dfrac{ "), i(1), t(" }{ "), i(2), t(" }") }),
        }),
    }, {
        condition = tex.in_mathzone,
    }),
    s({
        trig = "([\\%w{}%_%^]+)/",
        name = "fraction",
        regTrig = true,
    }, {
        t("\\frac{ "),
        f(function(_, snip)
            return snip.captures[1]
        end, {}),
        t(" }{ "),
        i(1),
        t(" }"),
    }, {
        condition = tex.in_mathzone,
    }),
    s({
        trig = "%((.*)%)/",
        name = "fraction",
        regTrig = true,
    }, {
        t("\\frac{ "),
        f(function(_, snip)
            return snip.captures[1]
        end, {}),
        t(" }{ "),
        i(1),
        t(" }"),
    }, {
        condition = tex.in_mathzone,
    }),
}

return snips, autosnips
