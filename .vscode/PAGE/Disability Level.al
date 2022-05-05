page 50041 "Disability Level"
{
    Caption = 'Level of Disability';
    PageType = List;
    SourceTable = "Disability Level";
    UsageCategory = Lists;
    ApplicationArea = all;

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
                field("Level of Disability"; "Level of Disability")
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

