report 50030 "TS_knjizenja 2"
{
    // // NK01 01.02.2018. - Excel export
    DefaultLayout = RDLC;
    RDLCLayout = './TS_knjizenja 2_real.rdl';


    dataset
    {
        dataitem(DataItem2; "Wage/Reduction Bank Accounts")
        {
            column(BankAccount; DataItem2."Account No")
            { }
            column(TodayDate; TodayDate)
            { }
            column(Picture; Comp.Picture)
            {

            }
            dataitem(DataItem1; "Payment Order")
            {

                column(Uplatio1; Uplatio1)
                {
                }
                column(Uplatio2; Uplatio2)
                {
                }
                column(Uplatio3; Uplatio3)
                {

                }
                column(JIB; JIB) { }
                column(SvrhaDoznake1; SvrhaDoznake1)
                {
                }
                column(SvrhaDoznake2; SvrhaDoznake2)
                {
                }
                column(SvrhaDoznake3; SvrhaDoznake3)
                {
                }
                column(Primalac1; Primalac1)
                {
                }
                column(Primalac2; Primalac2)
                {
                }
                column(Primalac3; Primalac3)
                {
                }
                column(TotalBank; TotalBank)
                {


                }

                column(MjestoUplate; MjestoUplate)
                {
                }
                column(RacunPosiljaoca; RacunPosiljaoca)
                {
                }
                column(RacunPrimaoca; SvrhaDoznake1)
                {
                }
                column(Iznos; Iznos)
                {
                }
                column(BrojPoreznogObaveznika; BrojPoreznogObaveznika)
                {
                }
                column(VrstaPrihoda; VrstaPrihoda)
                {
                }
                column(PorezniPeriodOd; PorezniPeriodOd)
                {
                }
                column(PorezniPeriodDo; PorezniPeriodDo)
                {
                }
                column(Opstina; Opstina)
                {
                }
                column(PozivNaBroj; PozivNaBroj)
                {
                }
                column(LastName; LastName)
                {
                }
                column(FirstName; FirstName)
                {
                }
                column(EmployeeID; EmployeeID)
                {
                }
                column(RedniBr; RedniBr)
                {

                }
                column(RecutionDesc; RecutionDesc)
                {

                }
                column(NazivBanke; NazivBanke)
                {

                }
                column(Year; Year)
                {

                }
                column(Month; Month) { }
                column(Org; Org) { }


                trigger OnAfterGetRecord()
                begin
                    Comp.get();
                    Comp.CalcFields(Picture);
                    if Employee.Get(DataItem1.SvrhaDoznake3) then
                        JMBG := Employee."Employee ID"
                    else
                        JMBG := '';

                    //Org





                    ReductionType.Reset();
                    ReductionType.SetFilter(Code, '%1', DataItem1."Reduction Type");
                    if ReductionType.FindFirst() then
                        RecutionDesc := ReductionType.Description
                    else
                        RecutionDesc := '';

                    NazivBanke := '';
                    //Wage/Reduction Bank Accounts
                    WageReductionBank.Reset();
                    WageReductionBank.SetFilter("Account No", '%1', DataItem1.RacunPrimaoca);
                    if WageReductionBank.FindFirst() then begin
                        WageBank.Reset();
                        WageBank.SetFilter(Code, '%1', WageReductionBank."Bank Code");
                        if WageBank.FindFirst() then NazivBanke := WageBank.Name;





                    end;
                    WH.Reset();
                    wh.SetFilter("No.", '%1', DataItem1."Wage Header No.");
                    WH.FindFirst();

                    Year := WH."Year Of Wage";
                    Month := WH."Month Of Wage";


                    ECL.Reset();
                    ECL.SetFilter("Employee No.", '%1', DataItem1.SvrhaDoznake3);
                    ECL.SetFilter("Starting Date", '<=%1', WH."Closing Date");
                    ECL.SetCurrentKey("Starting Date");
                    ECL.Ascending;
                    if ECL.FindLast() then begin
                        Org := ECL."Department Code";
                        OrgDijelovi.Reset();
                        OrgDijelovi.SetFilter(Description, '%1', ECL."Org Unit Name");
                        OrgDijelovi.SetFilter(Active, '%1', true);
                        if OrgDijelovi.FindFirst() then
                            JIB := OrgDijelovi."JIB Contributes"
                        else
                            JIB := '';
                    end

                    else begin
                        Org := '';

                        JIB := '';

                    end;




                    WBTemp.Reset();
                    WBTemp.SetFilter(Code, '%1', WageReductionBank."Bank Code");
                    if WBTemp.FindFirst() then begin
                        if Iznos <> 0 then begin
                            RedniBr := RedniBr + 1;
                            TotalBank := TotalBank + DataItem1.Iznos;

                        end;


                    end
                    else begin
                        WBTemp.Init();
                        WBTemp.Code := WageReductionBank."Bank Code";
                        WBTemp.Insert();
                        RedniBr := 1;
                        TotalBank := 0;

                    end;






                    Employee.SETFILTER("No.", '%1', SvrhaDoznake3);
                    IF Employee.FINDFIRST THEN BEGIN
                        FirstName := Employee."First Name";
                        LastName := Employee."Last Name";
                        EmployeeID := Employee."Employee ID";
                    END
                    ELSE BEGIN
                        FirstName := '';
                        LastName := '';
                        EmployeeID := '';
                    END;

                end;



                trigger OnPreDataItem()
                begin
                    FirstName := '';
                    TodayDate := Today;
                    Comp.get();
                    Comp.CalcFields(Picture);
                    LastName := '';
                    EmployeeID := '';
                    SETFILTER("Wage Header No.", '%1', Document);

                    // DataItemTableView = WHERE(Contributon = FILTER('Obustava'));
                    SETFILTER(Contributon, '%1', 'PLAĆA');
                    SETFILTER(RacunPrimaoca, '%1', DataItem2."Account No");

                end;
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }
    trigger OnInitReport()
    begin
        WBTemp.deleteall;
        RedniBr := 0;
    end;

    var
        i: Integer;
        JIB: Text[30];
        OrgDijelovi: Record "ORG Dijelovi";
        Org: Code[20];
        ECL: Record "Employee Contract Ledger";
        Year: Integer;
        Month: Integer;
        JMBG: Code[13];
        TodayDate: Date;
        WH: Record "Wage Header";
        a: Integer;
        NazivBanke: Text[2000];
        RecutionDesc: Text[1000];
        ReductionType: Record "Reduction Types";

        WSetup: Record "Wage Setup";
        WageReductionBank: Record "Wage/Reduction Bank Accounts";
        WVe: Record "Wage Value Entry";
        WBTemp: Record "Wage/Reduction Bank" temporary;
        Comp: Record "Company Information";
        RedniBr: Integer;

        WageBank: Record "Wage/Reduction Bank";
        TotalBank: Decimal;


        aRacunPosiljaoca: Text[250];
        aRacunPrimaoca: Text[250];
        avrstaPrihoda: Text[30];
        aOpstina: Text[30];
        aBrojPoreznogObaveznika: Text[100];
        aPozivNaBroj: Text[100];
        LastName: Text[100];
        FirstName: Text[100];
        EmployeeID: Text[100];
        Employee: Record "Employee";
        ExcelBuffer: Record "Excel Buffer";
        Document: Code[20];

    procedure SetParam(DocumentNo: Code[20])
    begin
        Document := DocumentNo;
    end;
}

