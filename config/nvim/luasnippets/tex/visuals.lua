local snips, autosnips = {}, {}

local tex = require("helper.latex")

autosnips = {
    s({
        trig = "U",
        name = "underbrace",
    }, {
        d(1, function(_, snip)
            local visual, env = "", snip.env
            if next(env.LS_SELECT_RAW) ~= nil then
                for _, ele in ipairs(snip.env.LS_SELECT_RAW) do
                    visual = visual .. ele .. "\n"
                end
                visual = string.sub(visual, 1, -2)
                return sn(nil, {
                    t("\\underbrace{ " .. visual .. " }_{"),
                    i(1),
                    t("}"),
                })
            else
                return sn(nil, t("U"))
            end
        end, {}),
    }, {
        condition = tex.in_mathzone,
    }),
    s({
        trig = "B",
        name = "underset",
    }, {
        d(1, function(_, snip)
            local visual, env = "", snip.env
            if next(env.LS_SELECT_RAW) ~= nil then
                for _, ele in ipairs(snip.env.LS_SELECT_RAW) do
                    visual = visual .. ele .. "\n"
                end
                visual = string.sub(visual, 1, -2)
                return sn(nil, {
                    t("\\underset{"),
                    i(1),
                    t("}{{ " .. visual .. " }}"),
                })
            else
                return sn(nil, t("B"))
            end
        end, {}),
    }, {
        condition = tex.in_mathzone,
    }),
    s({
        trig = "K",
        name = "cancelto",
    }, {
        d(1, function(_, snip)
            local visual, env = "", snip.env
            if next(env.LS_SELECT_RAW) ~= nil then
                for _, ele in ipairs(snip.env.LS_SELECT_RAW) do
                    visual = visual .. ele .. "\n"
                end
                visual = string.sub(visual, 1, -2)
                return sn(nil, {
                    t("\\cancelto{"),
                    i(1),
                    t("}{{ " .. visual .. " }}"),
                })
            else
                return sn(nil, t("K"))
            end
        end, {}),
    }, {
        condition = tex.in_mathzone,
    }),
    s({
        trig = "C",
        name = "cancel",
    }, {
        f(function(_, snip)
            local visual, env = "", snip.env
            if next(env.LS_SELECT_RAW) ~= nil then
                for _, ele in ipairs(snip.env.LS_SELECT_RAW) do
                    visual = visual .. ele .. "\n"
                end
                visual = string.sub(visual, 1, -2)
                return "\\cancel{ " .. visual .. " }"
            else
                return "C"
            end
        end, {}),
    }, {
        condition = tex.in_mathzone,
    }),
    s({
        trig = "S",
        name = "square root",
    }, {
        f(function(_, snip)
            local visual, env = "", snip.env
            if next(env.LS_SELECT_RAW) ~= nil then
                for _, ele in ipairs(snip.env.LS_SELECT_RAW) do
                    visual = visual .. ele .. "\n"
                end
                visual = string.sub(visual, 1, -2)
                return "\\sqrt{ " .. visual .. " }"
            else
                return "S"
            end
        end, {}),
    }, {
        condition = tex.in_mathzone,
    }),
}

return snips, autosnips
