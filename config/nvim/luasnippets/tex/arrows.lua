local snips, autosnips = {}, {}

local tex = require("helper.latex")

autosnips = {
    s(
        { trig = "->", wordTrig = false, name = "rightarrow ->" },
        { t("\\rightarrow ") },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "-->", wordTrig = false, name = "longrightarrow -->" },
        { t("\\longrightarrow ") },
        { condition = tex.in_mathzone }
    ),
    s({ trig = "<-", wordTrig = false, name = "leftarrow <-" }, { t("\\leftarrow ") }, { condition = tex.in_mathzone }),
    s(
        { trig = "<--", wordTrig = false, name = "longleftarrow <-" },
        { t("\\longleftarrow ") },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "<->", wordTrig = false, name = "leftrightarrow <->" },
        { t("\\leftrightarrow ") },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "<-->", wordTrig = false, name = "longleftrightarrow <-->" },
        { t("\\longleftrightarrow ") },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "=>", wordTrig = false, name = "Rightarrow =>" },
        { t("\\Rightarrow ") },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "==>", wordTrig = false, name = "Longrightarrow ==>" },
        { t("\\Longrightarrow ") },
        { condition = tex.in_mathzone }
    ),
    s({ trig = "=<", wordTrig = false, name = "Leftarrow =<" }, { t("\\Leftarrow ") }, { condition = tex.in_mathzone }),
    s(
        { trig = "<==", wordTrig = false, name = "Longleftarrow <==" },
        { t("\\Longleftarrow ") },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "<=>", wordTrig = false, name = "Leftrightarrow <=>" },
        { t("\\Leftrightarrow ") },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "<==>", wordTrig = false, name = "Longleftrightarrow <==>" },
        { t("\\Longleftrightarrow ") },
        { condition = tex.in_mathzone }
    ),
    s({ trig = "|->", wordTrig = false, name = "mapsto |->" }, { t("\\mapsto ") }, { condition = tex.in_mathzone }),
    s(
        { trig = "impby", wordTrig = false, name = "impliedby =<" },
        { t("\\impliedby ") },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "iff", wordTrig = false, name = "If and only if <=>" },
        { t("\\iff ") },
        { condition = tex.in_mathzone }
    ),
}

return snips, autosnips
