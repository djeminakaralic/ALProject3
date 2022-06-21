page 50133 "Vacation setup history"
{
    Caption = 'Vacation setup history';
    PageType = List;
    SourceTable = "Vacation setup history";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {

                field("Base Days"; "Base Days")
                {
                    ApplicationArea = all;

                }
                field("Base Days BD"; "Base Days BD")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Base Days RS"; "Base Days RS")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field(Year; Year)
                {
                    ApplicationArea = all;
                }
                field("Days FBIH"; "Days FBIH")
                {
                    ApplicationArea = all;
                }
                field("Days RS"; "Days RS")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Days BD"; "Days BD")
                {
                    ApplicationArea = all;
                    Caption = '<Dani između dva prekida radnog odnosa (BD)>';
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }
}

