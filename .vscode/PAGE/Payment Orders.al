page 50042 "Payment Orders"
{
    Caption = 'Payment Orders';
    Editable = true;
    PageType = List;
    Permissions = TableData 50042 = d;
    SourceTable = "Payment Order";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; "Entry No.")
                {
                    Editable = false;
                }
                field(Type; Type)
                {
                    Editable = false;
                }
                field(Code; Code)
                {
                    Editable = false;
                }
                field(Contributon; Contributon)
                {
                    Editable = false;
                }
                field(SvrhaDoznake1; SvrhaDoznake1)
                {
                    Editable = false;
                }
                field(RacunPrimaoca; RacunPrimaoca)
                {
                    Editable = true;
                }
                field(SvrhaDoznake2; SvrhaDoznake2)
                {
                    Editable = false;
                }
                field(SvrhaDoznake3; SvrhaDoznake3)
                {
                    Editable = false;
                }
                field(Primalac1; Primalac1)
                {
                    Editable = false;
                }
                field(Primalac2; Primalac2)
                {
                    Editable = false;
                }
                field(Primalac3; Primalac3)
                {
                    Editable = false;
                }
                field(Iznos; Iznos)
                {
                    Editable = true;
                }
                field(DatumUplate; DatumUplate)
                {
                    Editable = true;
                }
                field(VrstaPrihoda; VrstaPrihoda)
                {
                }
                field(PozivNaBroj; PozivNaBroj)
                {
                }
                field(Opstina; Opstina)
                {
                }
                field(BrojPoreznogObaveznika; BrojPoreznogObaveznika)
                {
                }
                field("User ID"; "User ID")
                {
                    Editable = false;
                }
                field("Date and Time Created"; "Date and Time Created")
                {
                    Editable = false;
                }
                field("Wage Calculation Type"; "Wage Calculation Type")
                {
                    Editable = false;
                }
                field(PorezniPeriodOd; PorezniPeriodOd)
                {
                }
                field(PorezniPeriodDo; PorezniPeriodDo)
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Sumarry per Payment Orders")
            {
                Caption = 'Sumarry per Payment Orders';
                Image = Report;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Report "Summary per Payment Orders";

                trigger OnAction()
                begin

                    //CurrPage.SETSELECTIONFILTER(PayOrder);
                    //Rec.PrintIt(PayOrder);
                end;
            }
            action("Zaključi UPP naloge")
            {
                Image = Report2;
                //ĐK  RunObject = Report 50093;
                Visible = false;
            }
            action("Ažuriraj datum uplate")
            {
                Image = "Report";
                Promoted = true;
                //ĐK  RunObject = Report 50096;
                Visible = false;
            }
            action(Print)
            {
                Caption = 'Print';
                Image = "Report";
                //ĐK RunObject = Report 99003803;vi
                Visible = false;

            }
        }
    }

    trigger OnOpenPage()
    begin

        UTemp.SETFILTER("User ID", '%1', USERID);
        IF UTemp.FINDFIRST THEN
            WageAllowed := UTemp."Wage Allowed";

        IF WageAllowed = FALSE THEN
            ERROR(error1);
        //INT1.0 end
    end;

    var
        PayOrder: Record "Payment Order";
        UTemp: Record "User Setup";
        WageAllowed: Boolean;
        error1: Label 'You do not have permission to access this report. Please contact your system administrator.';
}

