page 50049 Positions
{
    Caption = 'Positions';
    DelayedInsert = true;
    PageType = List;
    SourceTable = Position;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Code)
                {
                }
                field(Description; Description)
                {
                }
            }
        }
        area(factboxes)
        {


        }
    }

    actions
    {
        area(creation)
        {
            action("Job description")
            {
                Caption = 'Job description';
                Image = Job;
                Promoted = true;
                PromotedIsBig = true;
                //ĐKRunObject = Page "Job description";
                //ĐKRunPageLink = Job position Code=FIELD(Code);
                RunPageOnRec = false;

                trigger OnAction()
                begin
                    //JobDesc.SETRANGE("Job position Code",Code);
                    //PAGE.RUN(50050,JobDesc);
                end;
            }
            action("Training catalogue  -Position")
            {
                Caption = 'Training catalogue  -Position';
                Image = PersonInCharge;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    /* TC.SETRANGE("Position Code",Code);
                     PAGE.RUN(PAGE::"Training catalogue-Position",TC);*/
                end;
            }
            action("Position Languages")
            {
                Image = Language;
                //ĐK RunObject = Page 50073;
                //ĐKRunPageLink = Field1=FIELD(Code);
            }
            action("Position Qualification")
            {
                Caption = 'Position Qualification';
                Image = QualificationOverview;
                //ĐK RunObject = Page 50074;
                //ĐK RunPageLink = Document No.=FIELD(Code);
            }
        }
    }

    var
    /*  position: Record "50053";
      JobDesc: Record "50066";
      TC: Record ;
      */
}

