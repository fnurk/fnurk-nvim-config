---@diagnostic disable: undefined-global

return {
    s("freezed", fmt(
        [[{}
{} where _{}{{
    {}SickoMode();
}}]]     ,
        { c(1, { t("@unfreezed"), t("@freezed") }),
            i(2),
            rep(2),
            rep(2) })),
}
