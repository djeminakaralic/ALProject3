page 50095 "Points per Disability Status"
{
    Caption = 'Points per Disability Status';
    PageType = List;
    SourceTable = "Points per Disability Status";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                //ED 02 START
                field("Vacation Days Code"; "Vacation Days Code")
                {
                    ApplicationArea = all;
                }
                field(Category; Category)
                {
                    ApplicationArea = all;
                }
                //ED 02 END
                field(Description; Description)
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field(Points; Points)
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

