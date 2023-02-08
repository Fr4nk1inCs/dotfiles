local snips, autosnips = {}, {}

local tex = require("helper.latex")

autosnips = {
    s({
        trig = "oinf",
        name = "Integral from 0 to inf",
    }, {
        t("\\int_0^\\infty "),
        i(1),
        t("\\,\\mathrm{d}"),
        i(2, "x"),
        t(" "),
    }, {
        condition = tex.in_mathzone,
    }),
    s({
        trig = "iinf",
        name = "Integral from -inf to inf",
    }, {
        t("\\int_{-\\infty}^{\\infty} "),
        i(1),
        t("\\,\\mathrm{d}"),
        i(2, "x"),
        t(" "),
    }, {
        condition = tex.in_mathzone,
    }),
    s({
        trig = "dint",
        name = "Definite integral",
    }, {
        t("\\int_{"),
        i(1, "0"),
        t("}^{"),
        i(2, "\\infty"),
        t("} "),
        i(3),
        t("\\,\\mathrm{d}"),
        i(4, "x"),
        t(" "),
    }, {
        condition = tex.in_mathzone,
    }),
    s({
        trig = "\\?int",
        name = "Integral sign",
        regTrig = true,
        priority = 250,
    }, {
        t("\\int "),
        i(1),
        t("\\,\\mathrm{d}"),
        i(2, "x"),
        t(" "),
    }, {
        condition = tex.in_mathzone,
    }),
    s({
        trig = "\\?oint",
        name = "Contour integral sign",
    }, {
        t("\\oint "),
    }, {
        condition = tex.in_mathzone,
    }),
    s({
        trig = "\\?iint",
        name = "Double integral sign",
        priority = 500,
    }, {
        t("\\iint "),
    }, {
        condition = tex.in_mathzone,
    }),
    s({
        trig = "\\?iiint",
        name = "Triple integral sign",
        priority = 750,
    }, {
        t("\\iiint "),
    }, {
        condition = tex.in_mathzone,
    }),
}

return snips, autosnips
