page 50212 "Computer Knowledge"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Computer Knowledge";

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field("Program Code"; "Program Code")
                {
                    ApplicationArea = All;

                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}