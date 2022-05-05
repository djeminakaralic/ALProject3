page 52012 Roles
{
    Caption = 'Roles';
    PageType = List;
    SourceTable = "Role";

    layout
    {
        area(content)
        {
            repeater("J")
            {
                field(Code; Code)
                {
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                }
                field(Status; Status)
                {
                    ApplicationArea = all;
                }
            }
        }

    }

    actions
    {
    }
}

