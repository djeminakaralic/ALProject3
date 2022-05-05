page 50057 "Employee languages"
{
    PageType = List;
    SourceTable = "Employee languages";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Language Code"; "Language Code")
                {
                    TableRelation = Languages.Code;
                }
                field(Level; Level)
                {
                }
            }
        }
    }

    actions
    {
    }
}

