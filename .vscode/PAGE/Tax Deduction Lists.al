page 50275 "Tax Deduction Lists"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Tax deduction list";

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field("Entity Code"; "Entity Code")
                {
                    ApplicationArea = All;

                }
                field("Valid Year"; "Valid Year")
                {
                    ApplicationArea = all;
                }
                field(Month; Month)
                {
                    ApplicationArea = all;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = all;
                }
                field(Active; Active)
                {
                    ApplicationArea = all;

                }
            }
        }
    }



    var
        myInt: Integer;
}