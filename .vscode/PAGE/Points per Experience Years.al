page 50033 "Points per Experience Years"
{
    Caption = 'Points per Experience Years';
    PageType = List;
    SourceTable = "Points per Experience Years";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; No)
                {
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                }
                field(Vacation; Vacation)
                {
                    ApplicationArea = all;
                }
                field(LowerLimit; LowerLimit)
                {
                    ApplicationArea = all;
                }
                field(UpperLimit; UpperLimit)
                {
                    ApplicationArea = all;
                }
                field(UpperLimit2; UpperLimit2)
                {
                    ApplicationArea = all;
                }
                field(LowerLimit2; LowerLimit2)
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

