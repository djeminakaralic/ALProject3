page 50052 "Positions Minimal Education"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Position Minimal Education";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {

                field("Position Code"; "Position Code")
                {
                    ApplicationArea = all;
                }
                field("Position Name"; "Position Name")
                {
                    ApplicationArea = all;
                }
                field("Org Shema"; "Org Shema")
                {
                    ApplicationArea = All;

                }
                field("Minimal Education Level"; "Minimal Education Level")
                {
                    ApplicationArea = all;
                }
                field("School of Graduation"; "School of Graduation")
                {

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