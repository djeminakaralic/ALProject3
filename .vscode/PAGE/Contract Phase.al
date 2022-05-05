page 50096 "Contract Phase"
{
    Caption = 'Contract Phase';
    PageType = List;
    SourceTable = "Contract Phase t";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Internal ID"; "Internal ID")
                {
                    // Caption = 'Internal ID';
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Employee Full Name"; "Employee Full Name")
                {
                    //  Caption = 'Employee Full Name';
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Contract Phase"; "Contract Phase")
                {
                    BlankZero = true;
                    ShowMandatory = true;
                    ApplicationArea = all;
                }
                field("Contract Phase Date"; "Contract Phase Date")
                {
                    //   Caption = 'Contract Phase Date';
                    ApplicationArea = all;
                }
                field("Contract Phase Time"; "Contract Phase Time")
                {
                    // Caption = 'Contract Phase Time';
                    ApplicationArea = all;
                }
                field(Active; Active)
                {
                    ApplicationArea = all;
                }
                field("Starting Date"; "Starting Date")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Sector description"; "Sector description")
                {
                    //  Caption = 'Sector Description';
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Operator No."; "Operator No.")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin

        /*ContractPhase.RESET;
        ContractPhase.SETFILTER("Employee No.",ECL."Employee No.");
        ContractPhase.SETFILTER("No.",'%1',ECL."No.");
        ContractPhase.SETFILTER(Active,'%1',ECL.Active);
        IF ContractPhase.FINDLAST THEN BEGIN
        ECL.SETFILTER("Employee No.",'%1',"Employee No.");
        ECL.SETFILTER(Status,'%1',ECL.Status::Active);
        IF ECL.FINDLAST THEN BEGIN
        //"Contract Phase":=ECL."Contract Phase";
         // "Contract Phase Time":=ECL."Contract Phase Time";
          //"Contract Phase Date":=ECL."Contract Phase Date";
          ECL."Contract Phase":="Contract Phase";
          ECL."Contract Phase Time":="Contract Phase Time";
          ECL."Contract Phase Date":="Contract Phase Date";
          END;
          END;*/




    end;

    trigger OnOpenPage()
    begin
        ContractPhase.RESET;
        ContractPhase.SETFILTER("Employee No.", ECL."Employee No.");
        ContractPhase.SETFILTER("No.", '%1', ECL."No.");
        ContractPhase.SETFILTER(Active, '%1', TRUE);
    end;

    var
        CM: Record "Comission Members";
        // CMPage: Page "Comission Members";
        // Compensation: Record "Compensation";
        // CompensationPage: Page "Compensations";
        ContractPhase: Record "Contract Phase t";
        ECL: Record "Employee Contract Ledger";
}

