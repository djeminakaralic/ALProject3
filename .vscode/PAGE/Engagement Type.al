page 50216 "Engagement Type"
{
    PageType = List;
    SourceTable = "Engagement Type";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Code)
                {
                    ApplicationArea = all;
                }

                field(Description; Description)
                {
                    ApplicationArea = all;
                }
                field("No. of Contracts"; "No. of Contracts")
                {
                    ApplicationArea = all;
                }
                field("Hours in Day"; "Hours in Day")
                {
                    ApplicationArea = all;
                }
                field("Calculation Type"; "Calculation Type")
                {
                    ApplicationArea = all;
                }
                field("Termination Date Mandatory"; "Termination Date Mandatory")
                {
                    ApplicationArea = all;
                }
                field("Operator No."; "Operator No.")
                {
                    ApplicationArea = all;
                }
                field("Last Date Modified"; "Last Date Modified")
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

