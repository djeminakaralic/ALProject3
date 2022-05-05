page 50069 Department
{
    Caption = 'Department';
    PageType = List;
    SourceTable = "Department";
    UsageCategory = Administration;
    ApplicationArea = All;

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
                field(Type; Type)
                {
                }
                field("Sector Code"; "Sector Code")
                {
                }
            }
        }
    }

    actions
    {
    }
}

