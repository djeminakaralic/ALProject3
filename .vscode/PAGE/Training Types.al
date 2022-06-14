page 50270 "Training Types"
{
    // ApplicationArea = BasicEU;
    Caption = 'Trainings Types';
    PageType = List;
    SourceTable = "Training Type";
    //UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Code"; Code)
                {
                    ApplicationArea = all;

                }
                field(Description; Description)
                {
                    ApplicationArea = all;

                }
            }
        }
        /*area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
                Visible = false;
            }
        }*/
    }

    actions
    {
    }
}

