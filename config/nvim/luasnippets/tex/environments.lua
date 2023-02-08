local snips, autosnips = {}, {}

local tex = require("helper.latex")
local pipe = require("helper.utils").pipe

local function rec_ls()
    return sn(nil, {
        c(1, {
            t({ "" }),
            sn(nil, { t({ "", "\t\\item " }), i(1), d(2, rec_ls, {}) }),
        }),
    })
end

local function gen_env_snip(env)
    return s({
        trig = "\\" .. env,
        name = env:gsub("^%l", string.upper) .. "Environment",
        docstring = "\\begin{" .. env .. "}#1\n\\end{" .. env .. "}",
    }, {
        t({ "\\begin{" .. env .. "}" }),
        i(1),
        t({ "", "\\end{" .. env .. "}" }),
    }, {
        condition = conds.line_begin,
        show_condition = function()
            return false
        end,
    })
end

local function gen_env_snip_with_label(env, tagname)
    return s({
        trig = "\\" .. env,
        name = env:gsub("^%l", string.upper) .. "Environment",
        docstring = "\\begin{" .. env .. "}\n\t\\label{" .. tagname .. ":#1}\n\t#2\n\\end{" .. env .. "}",
    }, {
        t({ "\\begin{" .. env .. "}" }),
        t({ "", "\t\\label{" .. tagname .. ":" }),
        i(1),
        t({ "}", "\t" }),
        i(2),
        t({ "", "\\end{" .. env .. "}" }),
    }, {
        condition = conds.line_begin,
        show_condition = function()
            return false
        end,
    })
end

local envs = {
    "document",
    "abstract",
    "equation*",
    "align*",
    "alignat",
    "alignat*",
    "aligned",
    "gather*",
    "gathered",
    "multline*",
    "split",
    "cases",
    "matrix",
    "pmatrix",
    "bmatrix",
    "frame",
    "itemize",
    "enumerate",
    "description",
    "tikzpicture",
}

local envs_with_label = {
    ["equation"] = "eq",
    ["align"] = "eq",
    ["gather"] = "eq",
    ["multline"] = "eq",
    ["proof"] = "prf",
    ["theorem"] = "thm",
    ["lemma"] = "lem",
    ["corollary"] = "cor",
    ["definition"] = "def",
    ["example"] = "exmp",
    ["remark"] = "rmk",
}

snips = {
    s({
        trig = "\\figure",
        name = "Figure Environment",
        docstring = "\\begin{figure}[#1|htbp]\n\t\\centering\n\t#2\n\t\\caption{#3}\n\t\\label{fig:#4}\n\\end{figure}",
    }, {
        t({ "\\begin{figure}[" }),
        i(1, "htbp"),
        t({ "]", "\t\\centering", "\t" }),
        i(2),
        t({ "", "\t\\caption{" }),
        i(3),
        t({ "}", "\t\\label{fig:" }),
        i(4),
        t({ "}", "\\end{figure}" }),
    }, {
        condition = pipe({ conds.line_begin, tex.in_text }),
        show_condition = function()
            return false
        end,
    }),
    s({
        trig = "\\table",
        name = "Table Environment",
        docstring = "\\begin{table}[#1|htbp]\n\t\\centering\n\t\\caption{#2}\n\t\\label{tab:#3}\n\t#4\n\\end{table}",
    }, {
        t({ "\\begin{table}[" }),
        i(1, "htbp"),
        t({ "]", "\t\\centering", "\t\\caption{" }),
        i(2),
        t({ "}", "\t\\label{tab:" }),
        i(3),
        t({ "}", "\t" }),
        i(4),
        t({ "", "\\end{table}" }),
    }, {
        condition = pipe({ conds.line_begin, tex.in_text }),
        show_condition = function()
            return false
        end,
    }),
    s({
        trig = "\\tabular",
        name = "Tabular Environment",
        docstring = "\\begin{tabular}{#1}\n\t#2\n\\end{tabular}",
    }, {
        t({ "\\begin{tabular}{" }),
        i(1),
        t({ "}", "\t" }),
        i(2),
        t({ "", "\\end{tabular}" }),
    }, {
        condition = pipe({ conds.line_begin, tex.in_text }),
        show_condition = function()
            return false
        end,
    }),
    s({
        trig = "\\lstlisting",
        name = "Lstlisting Environment",
        docstring = "\\begin{lstlisting}[\n\tcaption={#1},\n\tlabel={lst:#2},\n\tlanguage={#3|C}]\n#4\\end{lstlisting}",
    }, {
        t({ "\\begin{lstlisting}[", "\tcaption={" }),
        i(1),
        t({ "},", "\tlabel={lst:" }),
        i(2),
        t({ "},", "\tlanguage={" }),
        i(3, "C"),
        t({ "}]", "" }),
        i(4),
        t({ "\\end{lstlisting}" }),
    }, {
        condition = pipe({ conds.line_begin, tex.in_text }),
        show_condition = function()
            return false
        end,
    }),
    s({
        trig = "\\prosol",
        name = "Problem and Solution Environment",
        docstring = "\\begin{problem}\n\t#1\n\\end{problem}\n\\begin{solution}\n\t#2\n\\end{solution}",
    }, {
        t({ "\\begin{problem}", "\t" }),
        i(1),
        t({ "", "\\end{problem}", "\\begin{solution}", "\t" }),
        i(2),
        t({ "", "\\end{solution}", "" }),
    }, {
        condition = pipe({ conds.line_begin, tex.in_text }),
        show_condition = function()
            return false
        end,
    }),
}

for _, env in ipairs(envs) do
    table.insert(snips, gen_env_snip(env))
end

for env, tagname in pairs(envs_with_label) do
    table.insert(snips, gen_env_snip_with_label(env, tagname))
end

autosnips = {
    s({ trig = "upkg", name = "usepackage" }, { t("\\usepackage{"), i(1), t("}") }, { condition = conds.line_begin }),
    s(
        { trig = "beg", name = "begin{} end{}" },
        { t({ "\\begin{" }), i(1), t({ "}", "\t" }), i(2), t({ "", "\\end{" }), rep(1), t({ "}" }) },
        { condition = conds.line_begin }
    ),
    s(
        { trig = "beq", name = "Equation Environment", dscr = "Create an equation environment." },
        { t({ "\\begin{equation}", "\t" }), i(1), t({ "", "\\end{equation}" }) },
        { condition = pipe({ conds.line_begin, tex.in_text }) }
    ),
    s(
        { trig = "bleq", name = "Equation Environment", dscr = "Create an equation environment." },
        { t({ "\\begin{equation}", "\t\\label{eq:" }), i(1), t({ "}", "\t" }), i(2), t({ "", "\\end{equation}" }) },
        { condition = pipe({ conds.line_begin, tex.in_text }) }
    ),
    s(
        { trig = "mk", name = "Inline Equation Environment", dscr = "Create an inline equation environment." },
        { t({ "$" }), i(1), t({ "$" }) },
        { condition = tex.in_text }
    ),
    s(
        { trig = "dm", name = "Inline Equation Environment", dscr = "Create an inline equation environment." },
        { t({ "\\[", "" }), i(1), t({ "", "\\]" }) },
        { condition = pipe({ conds.line_begin, tex.in_text }) }
    ),
    s(
        { trig = "bit", name = "Itemize Environment", dscr = "Create an itemize environment" },
        { t({ "\\begin{itemize}", "\t\\item " }), i(1), d(2, rec_ls, {}), t({ "", "\\end{itemize}" }) },
        { condition = pipe({ conds.line_begin, tex.in_text }) }
    ),
    s(
        { trig = "ben", name = "Enumerate Environment" },
        { t({ "\\begin{enumerate}", "\t\\item " }), i(1), d(2, rec_ls, {}), t({ "", "\\end{enumerate}" }) },
        { condition = pipe({ conds.line_begin, tex.in_text }) }
    ),
    s({ trig = "lben", name = "Enumerate with labels" }, {
        t({ "\\begin{enumerate}[label=(\\" }),
        c(1, {
            t("alph"),
            t("roman"),
            t("arabic"),
        }),
        t({ "*)]", "\t\\item " }),
        i(2),
        d(3, rec_ls, {}),
        t({ "", "\\end{enumerate}" }),
    }, { condition = pipe({ conds.line_begin, tex.in_text }) }),
}

return snips, autosnips
