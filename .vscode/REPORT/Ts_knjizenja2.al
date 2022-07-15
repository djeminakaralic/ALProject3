report 50030 "TS_knjizenja 2"
{
    // // NK01 01.02.2018. - Excel export
    DefaultLayout = RDLC;
    RDLCLayout = './TS_knjizenja 2_real.rdl';
    UseRequestPage = true;
    ProcessingOnly = false;
    PreviewMode = PrintLayout;


    dataset
    {
        dataitem(DataItem2; "Wage/Reduction Bank Accounts")
        {
            RequestFilterFields = "Bank Code";
            column(BankAccount; DataItem2."Account No")
            { }
            column(TodayDate; TodayDate)
            { }
            column(Picture; Comp.Picture)
            {

            }
            column(NazivBanke; NazivBanke)
            {

            }
            column(SlikaVisible; SlikaVisible) { }
            column(IznosU; IznosU) { }
            column(Naslov; Naslov) { }
            column(VrstaUplate; VrstaUplate) { }
            column(SvrhaDOz; SvrhaDOz) { }
            column(Racun; Racun) { }
            column(KontaktMail; KontaktMail) { }
            column(Emal; Emal) { }
            column(Tel; Tel) { }
            column(Sektor; Sektor) { }
            column(Sluzba; Sluzba) { }
            column(ImeZ; ImeZ) { }
            column(Center; Center) { }
            column(GodinaVisible; GodinaVisible) { }
            column(DatumSVisible; DatumSVisible) { }
            column(MjesecVisible; MjesecVisible) { }
            column(SifraORGVisible; SifraORGVisible) { }
            column(JIBVisible; JIBVisible) { }
            column(RedniBRVisible; RedniBRVisible) { }
            column(PartijaVisible; PartijaVisible) { }
            column(JMBVisible; JMBVisible) { }
            column(BrojRacunaVisible; BrojRacunaVisible) { }
            column(ImeIPrezimeVisible; ImeIPrezimeVisible) { }
            column(IznosUpateVisible; IznosUpateVisible)
            { }
            dataitem(DataItem1; "Payment Order")
            {

                column(Uplatio1; Uplatio1)
                {
                }
                column(IsplataDatum; WH."Payment Date")
                {

                }
                column(Uplatio2; Uplatio2)
                {
                }
                column(Uplatio3; Uplatio3)
                {

                }
                column(JIB; JIB) { }
                column(SvrhaDoznake1; RacunPrimaoca2)
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
                    WH.Reset();
                    wh.SetFilter("No.", '%1', DataItem1."Wage Header No.");
                    WH.FindFirst();
                    UserS.Reset();
                    UserS.SetFilter("User ID", '%1', USERID);
                    if UserS.FindFirst() then begin
                        ECL.Reset();
                        ECL.SetFilter("Starting Date", '<=%1', WH."Payment Date");
                        ECL.SetFilter("Employee No.", '%1', UserS."Employee No. for Wage");
                        ECL.SetCurrentKey("Starting Date");
                        ecl.Ascending;
                        if ECL.FindLast() then begin
                            Sektor := ECL."Sector Description";
                            Sluzba := ECL."Department Cat. Description";
                            Emal := UserS."E-Mail";
                            Tel := UserS."Phone No.";

                        end
                        else begin
                            Sektor := '';
                            Sluzba := '';
                            Emal := '';
                            Tel := '';

                        end;


                    end
                    else begin
                        Sektor := '';
                        Sluzba := '';
                        Emal := '';
                        Tel := '';

                    end;

                    //Đk
                    if strpos(DataItem2."Bank Code", 'INTESA') <> 0 then begin
                        GodinaVisible := False;
                        DatumSVisible := false;
                        MjesecVisible := false;
                        SifraORGVisible := false;
                        ImeZ := 'Ime i prezime';
                        JIBVisible := false;
                        RedniBRVisible := true;
                        PartijaVisible := false;
                        ImeIPrezimeVisible := true;
                        JMBVisible := false;
                        BrojRacunaVisible := true;
                        Center := true;
                        IznosUpateVisible := true;
                        IznosU := 'Iznos uplate';
                        SlikaVisible := true;
                        Sektor := '';
                        Sluzba := '';
                        Emal := '';
                        Tel := '';
                        Racun := 'Broj računa';
                        VrstaUplate := '';
                        SvrhaDOz := '';
                        Naslov := 'Spisak radnika za isplatu plaće i ostalih primanja na dan ' + format(WH."Payment Date") + ' godine';
                    end;
                    if strpos(DataItem2."Bank Code", 'SBER') <> 0 then begin
                        GodinaVisible := False;
                        MjesecVisible := false;
                        SifraORGVisible := false;
                        IznosU := 'Iznos';
                        JIBVisible := false;
                        RedniBRVisible := true;
                        VrstaUplate := '';
                        SvrhaDOz := '';
                        DatumSVisible := false;
                        PartijaVisible := true;
                        ImeIPrezimeVisible := true;
                        ImeZ := 'Ime i prezime';
                        Racun := 'Broj računa';
                        JMBVisible := true;
                        BrojRacunaVisible := false;
                        IznosUpateVisible := true;
                        SlikaVisible := true;
                        Sektor := '';
                        Sluzba := '';
                        Emal := '';
                        Tel := '';
                        Center := false;
                        Naslov := 'Spisak uposlenih za isplatu  plaće i ostalih primanja na dan  ' + format(WH."Payment Date") + ' godine';
                    end;

                    if strpos(DataItem2."Bank Code", 'ASA') <> 0 then begin
                        GodinaVisible := true;
                        MjesecVisible := true;
                        SifraORGVisible := true;
                        VrstaUplate := '';
                        SvrhaDOz := '';
                        IznosU := 'Iznos';
                        DatumSVisible := true;
                        JIBVisible := false;
                        Racun := 'TRN ASA';
                        ImeZ := 'Ime';
                        RedniBRVisible := false;
                        PartijaVisible := false;
                        ImeIPrezimeVisible := true;
                        JMBVisible := false;
                        BrojRacunaVisible := true;
                        IznosUpateVisible := true;
                        SlikaVisible := true;
                        Center := false;
                        Naslov := '';
                    end;


                    if strpos(DataItem2."Bank Code", 'NEDEF') <> 0 then begin
                        GodinaVisible := false;
                        MjesecVisible := false;
                        SifraORGVisible := false;
                        IznosU := 'Iznos u KM';
                        DatumSVisible := false;
                        JIBVisible := true;
                        Racun := 'broj računa zaposlenika';
                        ImeZ := 'Ime i prezime zaposlenika';
                        RedniBRVisible := false;
                        PartijaVisible := false;
                        ImeIPrezimeVisible := true;
                        JMBVisible := false;
                        BrojRacunaVisible := true;
                        IznosUpateVisible := true;
                        SlikaVisible := false;
                        Center := false;
                        Naslov := '';
                        Sektor := '';
                        Sluzba := '';
                        Emal := '';
                        Tel := '';
                        if DataItem1."Wage Calculation Type" = DataItem1."Wage Calculation Type"::Regular then
                            VrstaUplate := 'Redovno'
                        else
                            VrstaUplate := Format(DataItem1."Wage Calculation Type");
                        if DataItem1.PorezniPeriodDo = 0D then
                            DataItem1.PorezniPeriodDo := WH."Payment Date";

                        SvrhaDOz := 'Plaća za ' + format(Date2DMY(DataItem1.PorezniPeriodDo, 2)) + '/' + format(Date2DMY(DataItem1.PorezniPeriodDo, 3));
                    end;

                    //15.03.2022. godine
                    Primalac1 := DataItem1.RacunPrimaoca;




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
                        KontaktMail := WageBank."Contact E-mail";




                    end
                    ;



                    RacunPrimaoca2 := DataItem1.SvrhaDoznake1;
                    if RacunPrimaoca2 = 'Neto na račun' then
                        RacunPrimaoca2 := '';

                    Year := WH."Year Of Wage";
                    Month := WH."Month Of Wage";


                    ECL.Reset();
                    ECL.SetFilter("Employee No.", '%1', DataItem1.SvrhaDoznake3);
                    ECL.SetFilter("Starting Date", '<=%1', WH."Closing Date");
                    ECL.SetCurrentKey("Starting Date");
                    ECL.Ascending;
                    if ECL.FindLast() then begin

                        OrgDijelovi.Reset();
                        OrgDijelovi.SetFilter(Description, '%1', ECL."Org Unit Name");
                        OrgDijelovi.SetFilter(Active, '%1', true);
                        if OrgDijelovi.FindFirst() then
                            JIB := OrgDijelovi."JIB Contributes"
                        else
                            JIB := '';
                        Org := OrgDijelovi.Code;
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
            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin

            end;
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

        //ĐK     i: Integer;
        IznosU: Text[250];
        SvrhaDOz: Text[250];
        VrstaUplate: Text[250];

        KontaktMail: Text[250];
        Sektor: Text[250];
        Sluzba: Text[250];
        Tel: Text[250];
        Emal: Text[250];
        UserS: Record "User Setup";
        DatumSVisible: Boolean;
        GodinaVisible: Boolean;
        ImeZ: Text[250];
        Center: Boolean;
        SlikaVisible: Boolean;
        Naslov: Text[250];
        RacunPrimaoca2: Text[250];
        MjesecVisible: Boolean;
        SifraORGVisible: Boolean;
        JIBVisible: Boolean;
        RedniBRVisible: Boolean;
        PartijaVisible: Boolean;

        ImeIPrezimeVisible: Boolean;
        JMBVisible: Boolean;
        BrojRacunaVisible: Boolean;
        IznosUpateVisible: Boolean;
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
        Racun: Text[250];
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

