local snips, autosnips = {}, {}

local tex = require("helper.latex")

autosnips = {
    s({ trig = "(", name = "( and )", priority = 500, wordTrig = false }, { t("("), i(1), t(")") }),
    s({ trig = "[", name = "[ and ]", priority = 500, wordTrig = false }, { t("["), i(1), t("]") }),
    s({ trig = "{", name = "{ and }", priority = 500, wordTrig = false }, { t("{"), i(1), t("}") }),
    s({ trig = "\\{", name = "\\{ and \\}", wordTrig = false }, { t("\\{"), i(1), t("\\}") }),
    s(
        { trig = "`", name = "` and '", priority = 500, wordTrig = false },
        { t("`"), i(1), t("'") },
        { condition = tex.in_text }
    ),
    s(
        { trig = "$", name = "$ and $", priority = 500, wordTrig = false },
        { t("$"), i(1), t("$") },
        { condition = tex.in_text }
    ),
    s(
        { trig = "\\(", name = "\\( and \\)", priority = 750 },
        { t("\\("), i(1), t("\\)") },
        { condition = tex.in_text }
    ),
    s(
        { trig = "\\[", name = "\\[ and \\]", priority = 750 },
        { t({ "\\[", "    " }), i(1), t({ "", "\\]" }) },
        { condition = tex.in_text }
    ),
    -- \left \right
    s(
        { trig = "lr(", name = "left( and right)" },
        { t({ "\\left( " }), i(1), t({ "\\right)" }) },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "lr|", name = "left| and right|" },
        { t({ "\\left\\lvert " }), i(1), t({ "\\right\\rvert" }) },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "lr\\|", name = "left|| and right||" },
        { t({ "\\left\\| " }), i(1), t({ "\\right\\|" }) },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "lr{", name = "left\\{ and right\\}" },
        { t({ "\\left\\{ " }), i(1), t({ "\\right\\}" }) },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "lrb", name = "left\\{ and right\\}" },
        { t({ "\\left\\{ " }), i(1), t({ "\\right\\}" }) },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "lr[", name = "left[ and right]" },
        { t({ "\\left[ " }), i(1), t({ "\\right]" }) },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "lr<", name = "leftangle rightangle" },
        { t({ "\\left\\langle " }), i(1), t({ "\\right\\rangle" }) },
        { condition = tex.in_mathzone }
    ),
}

return snips, autosnips
