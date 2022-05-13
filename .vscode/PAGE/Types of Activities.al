page 50128 "Types Of Activities"
{
    Caption = 'Types Of Activities';
    PageType = List;
    SourceTable = "Types Of Activities";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater("K")
            {
                field(Code; Code)
                {
                    ApplicationArea = all;
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
    }
}

