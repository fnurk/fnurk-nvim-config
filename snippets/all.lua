---@diagnostic disable: undefined-global

return {
    s("ternary",fmt([[{} ? {} : {}]], { i(1, "condition"), i(2, "true"), i(3, "false") })),
    s("rep", fmt([[input: {}, copy: {}]], { i(1), rep(1) })),
    s("select", fmt([[testing choices: {}]], { c(1, {t("hello"), t("yes")})})),
}
