page 50068 Language
{
    Caption = 'Languages';
    PageType = List;
    SourceTable = "Languages";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Code)
                {
                }
                field(Description; Description)
                {
                }
            }
        }
    }

    actions
    {
    }
}

