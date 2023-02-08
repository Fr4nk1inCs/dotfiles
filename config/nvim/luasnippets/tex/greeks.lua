local tex = require("helper.latex")

local snips, autosnips = {}, {}

autosnips = {
    -- Greek letter shortcut
    s({ trig = "@a", name = "alpha α", wordTrig = false }, { t("\\alpha") }, { condition = tex.in_mathzone }),
    s({ trig = "@A", name = "alpha α", wordTrig = false }, { t("\\alpha") }, { condition = tex.in_mathzone }),
    s({ trig = "@b", name = "beta β", wordTrig = false }, { t("\\beta") }, { condition = tex.in_mathzone }),
    s({ trig = "@B", name = "beta β", wordTrig = false }, { t("\\beta") }, { condition = tex.in_mathzone }),
    s({ trig = "@c", name = "chi χ", wordTrig = false }, { t("\\chi") }, { condition = tex.in_mathzone }),
    s({ trig = "@C", name = "chi χ", wordTrig = false }, { t("\\chi") }, { condition = tex.in_mathzone }),
    s({ trig = "@d", name = "delta δ", wordTrig = false }, { t("\\delta") }, { condition = tex.in_mathzone }),
    s({ trig = "@D", name = "Delta Δ", wordTrig = false }, { t("\\Delta") }, { condition = tex.in_mathzone }),
    s({ trig = "@e", name = "epsilon ε", wordTrig = false }, { t("\\epsilon") }, { condition = tex.in_mathzone }),
    s({ trig = "@E", name = "epsilon ε", wordTrig = false }, { t("\\epsilon") }, { condition = tex.in_mathzone }),
    s(
        { trig = ":e", name = "varepsilon ε", wordTrig = false },
        { t("\\varepsilon") },
        { condition = tex.in_mathzone }
    ),
    s({ trig = "@f", name = "phi φ", wordTrig = false }, { t("\\phi") }, { condition = tex.in_mathzone }),
    s({ trig = "@F", name = "Phi Φ", wordTrig = false }, { t("\\Phi") }, { condition = tex.in_mathzone }),
    s({ trig = ":f", name = "varphi 𝜑", wordTrig = false }, { t("\\varphi") }, { condition = tex.in_mathzone }),
    s({ trig = ":F", name = "varPhi Φ", wordTrig = false }, { t("\\varPhi") }, { condition = tex.in_mathzone }),
    s({ trig = "@g", name = "gamma γ", wordTrig = false }, { t("\\gamma") }, { condition = tex.in_mathzone }),
    s({ trig = "@G", name = "Gamma γ", wordTrig = false }, { t("\\Gamma") }, { condition = tex.in_mathzone }),
    s({ trig = "@h", name = "eta η", wordTrig = false }, { t("\\eta") }, { condition = tex.in_mathzone }),
    s({ trig = "@H", name = "eta η", wordTrig = false }, { t("\\eta") }, { condition = tex.in_mathzone }),
    s({ trig = "@i", name = "iota ι", wordTrig = false }, { t("\\iota") }, { condition = tex.in_mathzone }),
    s({ trig = "@I", name = "iota ι", wordTrig = false }, { t("\\iota") }, { condition = tex.in_mathzone }),
    s({ trig = "@k", name = "kappa κ", wordTrig = false }, { t("\\kappa") }, { condition = tex.in_mathzone }),
    s({ trig = "@K", name = "kappa κ", wordTrig = false }, { t("\\kappa") }, { condition = tex.in_mathzone }),
    s({ trig = ":k", name = "varkappa ϰ", wordTrig = false }, { t("\\varkappa") }, { condition = tex.in_mathzone }),
    s({ trig = "@l", name = "lambda λ", wordTrig = false }, { t("\\lambda") }, { condition = tex.in_mathzone }),
    s({ trig = "@L", name = "Lambda Λ", wordTrig = false }, { t("\\Lambda") }, { condition = tex.in_mathzone }),
    s({ trig = "@m", name = "mu μ", wordTrig = false }, { t("\\mu") }, { condition = tex.in_mathzone }),
    s({ trig = "@M", name = "mu μ", wordTrig = false }, { t("\\mu") }, { condition = tex.in_mathzone }),
    s({ trig = "@n", name = "nu ν", wordTrig = false }, { t("\\nu") }, { condition = tex.in_mathzone }),
    s({ trig = "@N", name = "nu ν", wordTrig = false }, { t("\\nu") }, { condition = tex.in_mathzone }),
    s({ trig = "@o", name = "omega ω", wordTrig = false }, { t("\\omega") }, { condition = tex.in_mathzone }),
    s({ trig = "@O", name = "Omega Ω", wordTrig = false }, { t("\\Omega") }, { condition = tex.in_mathzone }),
    s({ trig = "@p", name = "pi π", wordTrig = false }, { t("\\pi") }, { condition = tex.in_mathzone }),
    s({ trig = "@P", name = "Pi Π", wordTrig = false }, { t("\\Pi") }, { condition = tex.in_mathzone }),
    s({ trig = ":p", name = "varpi ϖ", wordTrig = false }, { t("\\varpi") }, { condition = tex.in_mathzone }),
    s({ trig = ":P", name = "varPi Π", wordTrig = false }, { t("\\varPi") }, { condition = tex.in_mathzone }),
    s({ trig = "@q", name = "theta θ", wordTrig = false }, { t("\\theta") }, { condition = tex.in_mathzone }),
    s({ trig = "@Q", name = "Theta Θ", wordTrig = false }, { t("\\Theta") }, { condition = tex.in_mathzone }),
    s({ trig = ":q", name = "vartheta ϑ", wordTrig = false }, { t("\\vartheta") }, { condition = tex.in_mathzone }),
    s({ trig = ":Q", name = "varTheta Θ", wordTrig = false }, { t("\\varTheta") }, { condition = tex.in_mathzone }),
    s({ trig = "@r", name = "rho ρ", wordTrig = false }, { t("\\rho") }, { condition = tex.in_mathzone }),
    s({ trig = "@R", name = "rho ρ", wordTrig = false }, { t("\\rho") }, { condition = tex.in_mathzone }),
    s({ trig = ":r", name = "varrho ϱ", wordTrig = false }, { t("\\varrho") }, { condition = tex.in_mathzone }),
    s({ trig = "@s", name = "sigma σ", wordTrig = false }, { t("\\sigma") }, { condition = tex.in_mathzone }),
    s({ trig = "@S", name = "Sigma Σ", wordTrig = false }, { t("\\Sigma") }, { condition = tex.in_mathzone }),
    s({ trig = "@t", name = "tau τ", wordTrig = false }, { t("\\tau") }, { condition = tex.in_mathzone }),
    s({ trig = "@T", name = "tau τ", wordTrig = false }, { t("\\tau") }, { condition = tex.in_mathzone }),
    s({ trig = "@u", name = "upsilon υ", wordTrig = false }, { t("\\upsilon") }, { condition = tex.in_mathzone }),
    s({ trig = "@U", name = "Upsilon Υ", wordTrig = false }, { t("\\Upsilon") }, { condition = tex.in_mathzone }),
    s({ trig = "@x", name = "xi ξ", wordTrig = false }, { t("\\xi") }, { condition = tex.in_mathzone }),
    s({ trig = "@X", name = "Xi Ξ", wordTrig = false }, { t("\\Xi") }, { condition = tex.in_mathzone }),
    s({ trig = "@y", name = "psi ψ", wordTrig = false }, { t("\\psi") }, { condition = tex.in_mathzone }),
    s({ trig = "@Y", name = "Psi Ψ", wordTrig = false }, { t("\\Psi") }, { condition = tex.in_mathzone }),
    s({ trig = "@z", name = "zeta χ", wordTrig = false }, { t("\\zeta") }, { condition = tex.in_mathzone }),
    s({ trig = "@Z", name = "zeta χ", wordTrig = false }, { t("\\zeta") }, { condition = tex.in_mathzone }),

    -- insert space after greek letters
    s(
        { trig = "(\\alpha)([%a])", name = "space after α", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1] .. " " .. snip.captures[2]
        end, {}) },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "(\\beta)([%a])", name = "space after β", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1] .. " " .. snip.captures[2]
        end, {}) },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "(\\chi)([%a])", name = "space after χ", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1] .. " " .. snip.captures[2]
        end, {}) },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "(\\delta)([%a])", name = "space after δ", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1] .. " " .. snip.captures[2]
        end, {}) },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "(\\Delta)([%a])", name = "space after Δ", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1] .. " " .. snip.captures[2]
        end, {}) },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "(\\epsilon)([%a])", name = "space after ε", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1] .. " " .. snip.captures[2]
        end, {}) },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "(\\varepsilon)([%a])", name = "space after ε", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1] .. " " .. snip.captures[2]
        end, {}) },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "(\\phi)([%a])", name = "space after φ", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1] .. " " .. snip.captures[2]
        end, {}) },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "(\\Phi)([%a])", name = "space after Φ", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1] .. " " .. snip.captures[2]
        end, {}) },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "(\\varphi)([%a])", name = "space after 𝜑", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1] .. " " .. snip.captures[2]
        end, {}) },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "(\\varPhi)([%w])", name = "space after Φ", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1] .. " " .. snip.captures[2]
        end, {}) },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "(\\gamma)([%a])", name = "space after γ", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1] .. " " .. snip.captures[2]
        end, {}) },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "(\\Gamma)([%a])", name = "space after γ", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1] .. " " .. snip.captures[2]
        end, {}) },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "(\\eta)([%a])", name = "space after η", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1] .. " " .. snip.captures[2]
        end, {}) },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "(\\iota)([%a])", name = "space after ι", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1] .. " " .. snip.captures[2]
        end, {}) },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "(\\kappa)([%a])", name = "space after κ", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1] .. " " .. snip.captures[2]
        end, {}) },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "(\\varkappa)([%a])", name = "space after ϰ", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1] .. " " .. snip.captures[2]
        end, {}) },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "(\\lambda)([%a])", name = "space after λ", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1] .. " " .. snip.captures[2]
        end, {}) },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "(\\Lambda)([%a])", name = "space after Λ", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1] .. " " .. snip.captures[2]
        end, {}) },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "(\\mu)([%a])", name = "space after μ", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1] .. " " .. snip.captures[2]
        end, {}) },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "(\\nu)([%a])", name = "space after ν", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1] .. " " .. snip.captures[2]
        end, {}) },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "(\\omega)([%a])", name = "space after ω", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1] .. " " .. snip.captures[2]
        end, {}) },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "(\\Omega)([%a])", name = "space after Ω", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1] .. " " .. snip.captures[2]
        end, {}) },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "(\\pi)([%a])", name = "space after π", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1] .. " " .. snip.captures[2]
        end, {}) },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "(\\Pi)([%a])", name = "space after π", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1] .. " " .. snip.captures[2]
        end, {}) },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "(\\varpi)([%a])", name = "space after ϖ", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1] .. " " .. snip.captures[2]
        end, {}) },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "(\\varPi)([%w])", name = "space after Π", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1] .. " " .. snip.captures[2]
        end, {}) },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "(\\theta)([%a])", name = "space after θ", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1] .. " " .. snip.captures[2]
        end, {}) },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "(\\Theta)([%a])", name = "space after Θ", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1] .. " " .. snip.captures[2]
        end, {}) },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "(\\vartheta)([%a])", name = "space after ϑ", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1] .. " " .. snip.captures[2]
        end, {}) },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "(\\varTheta)([%w])", name = "space after Θ", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1] .. " " .. snip.captures[2]
        end, {}) },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "(\\rho)([%a])", name = "space after ρ", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1] .. " " .. snip.captures[2]
        end, {}) },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "(\\varrho)([%a])", name = "space after ϱ", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1] .. " " .. snip.captures[2]
        end, {}) },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "(\\sigma)([%a])", name = "space after σ", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1] .. " " .. snip.captures[2]
        end, {}) },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "(\\Sigma)([%a])", name = "space after Σ", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1] .. " " .. snip.captures[2]
        end, {}) },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "(\\tau)([%a])", name = "space after τ", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1] .. " " .. snip.captures[2]
        end, {}) },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "(\\upsilon)([%a])", name = "space after υ", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1] .. " " .. snip.captures[2]
        end, {}) },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "(\\Upsilon)([%a])", name = "space after Υ", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1] .. " " .. snip.captures[2]
        end, {}) },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "(\\xi)([%a])", name = "space after ξ", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1] .. " " .. snip.captures[2]
        end, {}) },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "(\\Xi)([%a])", name = "space after Ξ", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1] .. " " .. snip.captures[2]
        end, {}) },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "(\\psi)([%a])", name = "space after ψ", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1] .. " " .. snip.captures[2]
        end, {}) },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "(\\Psi)([%a])", name = "space after Ψ", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1] .. " " .. snip.captures[2]
        end, {}) },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "(\\zeta)([%a])", name = "space after χ", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1] .. " " .. snip.captures[2]
        end, {}) },
        { condition = tex.in_mathzone }
    ),

    -- Add backslash before greek symbols
    s(
        { trig = "([^\\])alpha", name = "backslash before alpha", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1]
        end, {}), t("\\alpha") },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "([^\\])beta", name = "backslash before beta", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1]
        end, {}), t("\\beta") },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "([^\\])chi", name = "backslash before chi", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1]
        end, {}), t("\\chi") },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "([^\\])delta", name = "backslash before delta", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1]
        end, {}), t("\\delta") },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "([^\\])Delta", name = "backslash before Delta", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1]
        end, {}), t("\\Delta") },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "([^\\])epsilon", name = "backslash before epsilon", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1]
        end, {}), t("\\epsilon") },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "([^\\])varepsilon", name = "backslash before varepsilon", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1]
        end, {}), t("\\varepsilon") },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "([^\\])phi", name = "backslash before phi", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1]
        end, {}), t("\\phi") },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "([^\\])Phi", name = "backslash before Phi", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1]
        end, {}), t("\\Phi") },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "([^\\])varphi", name = "backslash before varphi", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1]
        end, {}), t("\\varphi") },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "([^\\])varPhi", name = "backslash before varPhi", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1]
        end, {}), t("\\varPhi") },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "([^\\])gamma", name = "backslash before gamma", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1]
        end, {}), t("\\gamma") },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "([^\\])Gamma", name = "backslash before Gamma", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1]
        end, {}), t("\\Gamma") },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "([^\\])eta", name = "backslash before eta", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1]
        end, {}), t("\\eta") },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "([^\\])iota", name = "backslash before iota", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1]
        end, {}), t("\\iota") },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "([^\\])kappa", name = "backslash before kappa", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1]
        end, {}), t("\\kappa") },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "([^\\])varkappa", name = "backslash before varkappa", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1]
        end, {}), t("\\varkappa") },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "([^\\])lambda", name = "backslash before lambda", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1]
        end, {}), t("\\lambda") },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "([^\\])Lambda", name = "backslash before Lambda", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1]
        end, {}), t("\\Lambda") },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "([^\\])mu", name = "backslash before mu", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1]
        end, {}), t("\\mu") },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "([^\\])nu", name = "backslash before nu", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1]
        end, {}), t("\\nu") },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "([^\\])omega", name = "backslash before omega", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1]
        end, {}), t("\\omega") },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "([^\\])Omega", name = "backslash before Omega", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1]
        end, {}), t("\\Omega") },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "([^\\])pi", name = "backslash before pi", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1]
        end, {}), t("\\pi") },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "([^\\])Pi", name = "backslash before Pi", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1]
        end, {}), t("\\Pi") },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "([^\\])varpi", name = "backslash before varpi", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1]
        end, {}), t("\\varpi") },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "([^\\])varPi", name = "backslash before varPi", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1]
        end, {}), t("\\varPi") },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "([^\\])theta", name = "backslash before theta", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1]
        end, {}), t("\\theta") },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "([^\\])Theta", name = "backslash before Theta", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1]
        end, {}), t("\\Theta") },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "([^\\])vartheta", name = "backslash before vartheta", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1]
        end, {}), t("\\vartheta") },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "([^\\])varTheta", name = "backslash before varTheta", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1]
        end, {}), t("\\varTheta") },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "([^\\])rho", name = "backslash before rho", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1]
        end, {}), t("\\rho") },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "([^\\])varrho", name = "backslash before varrho", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1]
        end, {}), t("\\varrho") },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "([^\\])sigma", name = "backslash before sigma", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1]
        end, {}), t("\\sigma") },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "([^\\])Sigma", name = "backslash before Sigma", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1]
        end, {}), t("\\Sigma") },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "([^\\])tau", name = "backslash before tau", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1]
        end, {}), t("\\tau") },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "([^\\])upsilon", name = "backslash before upsilon", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1]
        end, {}), t("\\upsilon") },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "([^\\])Upsilon", name = "backslash before Upsilon", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1]
        end, {}), t("\\Upsilon") },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "([^\\])xi", name = "backslash before xi", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1]
        end, {}), t("\\xi") },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "([^\\])Xi", name = "backslash before Xi", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1]
        end, {}), t("\\Xi") },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "([^\\])psi", name = "backslash before psi", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1]
        end, {}), t("\\psi") },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "([^\\])Psi", name = "backslash before Psi", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1]
        end, {}), t("\\Psi") },
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "([^\\])zeta", name = "backslash before zeta", regTrig = true },
        { f(function(_, snip)
            return snip.captures[1]
        end, {}), t("\\zeta") },
        { condition = tex.in_mathzone }
    ),
}

return snips, autosnips
