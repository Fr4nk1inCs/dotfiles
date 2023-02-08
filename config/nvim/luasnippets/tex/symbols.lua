local snips, autosnips = {}, {}

local tex = require("helper.latex")

local autosnips = {
    s({
        trig = "ooo",
        name = "infinity",
    }, {
        t("\\infty "),
    }, {
        condition = tex.in_mathzone,
    }),
    s({
        trig = "\\?pm",
        name = "+-",
        regTrig = true,
    }, {
        t("\\pm "),
    }, {
        condition = tex.in_mathzone,
    }),
    s({
        trig = "...",
        name = "dots",
    }, {
        t("\\dots "),
    }, {
        condition = tex.in_mathzone,
    }),
    s({
        trig = "\\\\\\",
        name = "set minus",
    }, {
        t("\\setminus "),
    }, {
        condition = tex.in_mathzone,
    }),
    s({
        trig = "||",
        name = "mid",
    }, {
        t("\\mid "),
    }, {
        condition = tex.in_mathzone,
    }),
    s({
        trig = "~E",
        name = "exists",
    }, {
        t("\\exists "),
    }, {
        condition = tex.in_mathzone,
    }),
    s({
        trig = "~A",
        name = "forall",
    }, {
        t("\\forall "),
    }, {
        condition = tex.in_mathzone,
    }),
    s({
        trig = "Sq",
        name = "square",
    }, {
        t("\\square "),
    }, {
        condition = tex.in_mathzone,
    }),
    -- relations
    s({
        trig = "===",
        name = "equiv",
    }, {
        t("\\equiv "),
    }, {
        condition = tex.in_mathzone,
    }),
    s({
        trig = "!=",
        name = "not equal",
    }, {
        t("\\neq "),
    }, {
        condition = tex.in_mathzone,
    }),
    s({
        trig = ">=",
        name = "greater or equal",
    }, {
        t("\\geq "),
    }, {
        condition = tex.in_mathzone,
    }),
    s({
        trig = "<=",
        name = "less or equal",
    }, {
        t("\\leq "),
    }, {
        condition = tex.in_mathzone,
    }),
    s({
        trig = ">>",
        name = "much greater",
    }, {
        t("\\gg"),
    }, {
        condition = tex.in_mathzone,
    }),
    s({
        trig = "<<",
        name = "much less",
    }, {
        t("\\ll"),
    }, {
        condition = tex.in_mathzone,
    }),
    s({
        trig = "~~",
        name = "similar",
    }, {
        t("\\sim "),
    }, {
        condition = tex.in_mathzone,
    }),
    s({
        trig = "~=",
        name = "approximately equal",
    }, {
        t("\\approx "),
    }, {
        condition = tex.in_mathzone,
    }),
    s({
        trig = "\\?prop",
        name = "propto",
        regTrig = true,
    }, {
        t("\\propto"),
    }, {
        condition = tex.in_mathzone,
    }),
    s({
        trig = "\\?nabl",
        name = "nabla",
        regTrig = true,
    }, {
        t("\\nabla "),
    }, {
        condition = tex.in_mathzone,
    }),
    s({
        trig = "xx",
        name = "times",
    }, {
        t("\\times "),
    }, {
        condition = tex.in_mathzone,
    }),
    s({
        trig = "**",
        name = "cdot",
    }, {
        t("\\cdot "),
    }, {
        condition = tex.in_mathzone,
    }),
    s({
        trig = "\\cdot *",
        name = "cdots",
    }, {
        t("\\cdots"),
    }, {
        condition = tex.in_mathzone,
    }),
    s({
        trig = "\\?pal",
        name = "parallel",
        regTrig = true,
    }, {
        t("\\parallel "),
    }, {
        condition = tex.in_mathzone,
    }),
    -- special symbols
    s({
        trig = "[el]ll",
        name = "ell",
        regTrig = true,
    }, {
        t("\\ell "),
    }, {
        condition = tex.in_mathzone,
    }),
    s({
        trig = "LL",
        name = "mathcal L",
    }, {
        t("\\mathcal{L}"),
    }, {
        condition = tex.in_mathzone,
    }),
    s({
        trig = "HH",
        name = "mathcal H",
    }, {
        t("\\mathcal{H}"),
    }, {
        condition = tex.in_mathzone,
    }),
    s({
        trig = "CC",
        name = "complex set",
    }, {
        t("\\mathbb{C}"),
    }, {
        condition = tex.in_mathzone,
    }),
    s({
        trig = "RR",
        name = "real set",
    }, {
        t("\\mathbb{R}"),
    }, {
        condition = tex.in_mathzone,
    }),
    s({
        trig = "QQ",
        name = "rational set",
    }, {
        t("\\mathbb{Q}"),
    }, {
        condition = tex.in_mathzone,
    }),
    s({
        trig = "ZZ",
        name = "number set",
    }, {
        t("\\mathbb{Z}"),
    }, {
        condition = tex.in_mathzone,
    }),
    s({
        trig = "NN",
        name = "natural set",
    }, {
        t("\\mathbb{N}"),
    }, {
        condition = tex.in_mathzone,
    }),
    s({
        trig = "II",
        name = "base set",
    }, {
        t("\\mathbb{1}"),
    }, {
        condition = tex.in_mathzone,
    }),
}

return snips, autosnips
