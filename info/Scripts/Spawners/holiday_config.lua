HolidayConfig = {

    -- TESTING ONLY. Forces a specific holiday regardless of the current date.
    -- Set to nil in production. Values (testing only): "christmas", "halloween", "easter"
    holiday_override = nil,

    holidays = {
        christmas = {
            start_month = 12, start_day = 15,
            end_month   = 1,  end_day   = 5,
        },
        halloween = {
            start_month = 10, start_day = 15,
            end_month   = 11, end_day   = 2,
        },
        -- Easter date is computed automatically via Gregorian algorithm in C++.
        -- window_before/after = days relative to Easter Sunday to include.
        easter = {
            window_before = 5,
            window_after  = 7,
        },
    },
}
