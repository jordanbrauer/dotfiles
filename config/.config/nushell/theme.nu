export def CityLights [] {
    let palette = {
      Black: black
      White: white
      Grey: "#41505e"
      Steel: "#718ca1"
      Red: "#e27e8d"
      Green: "#54af83"
      Blue: '#68a1f0'
      Yellow: '#ebda65'
      Orange: "#ebbf83"
      Sage: "#008b94"
      Aqua: "#9effff"
      Teal: "#70e1e8"
      Azure: "#5ec4ff"
      Success: "#8bd49c"
      Error: red
      Column: "#242b33"
      Menu: "#14232d"
      Select: "#363C43"
    }

    {
      colour: $palette
      theme: {
        # color for nushell primitives
        leading_trailing_space_bg: { attr: n } # no fg, no bg, attr none effectively turns this off
        separator: $palette.Select
        header: $palette.Grey
        empty: $palette.Yellow
        bool: $palette.Red
        int: $palette.Red
        filesize: $palette.Red
        duration: $palette.Green
        date: $palette.Red
        range: $palette.Red
        float: $palette.Red
        string: $palette.Blue
        nothing: $palette.White
        binary: $palette.White
        cellpath: $palette.White
        row_index: $palette.Grey
        record: $palette.Steel
        list: $palette.Steel
        block: $palette.Steel
        hints: $palette.Grey

        # shapes are used to change the cli syntax highlighting
        shape_garbage: { fg: $palette.Black bg: $palette.Error attr: b}
        shape_binary: $palette.Red
        shape_bool: $palette.Red
        shape_int: $palette.Red
        shape_float: $palette.Red
        shape_range: yellow_bold
        shape_internalcall: $palette.Azure
        shape_external: $palette.Teal
        shape_externalarg: $palette.Green
        shape_literal: $palette.Blue
        shape_operator: $palette.Azure
        shape_signature: $palette.Azure
        shape_string: $palette.Blue
        shape_string_interpolation: $palette.Steel
        shape_datetime: $palette.Red
        shape_list: cyan_bold
        shape_table: blue_bold
        shape_record: cyan_bold
        shape_block: blue_bold
        shape_filepath: $palette.Blue
        shape_globpattern: cyan_bold
        shape_variable: $palette.Orange
        shape_flag: blue_bold
        shape_custom: green
        shape_nothing: light_cyan
      }
    }
}
