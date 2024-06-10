#include<bits/stdc++.h>
using namespace std;

class SymbolInfo{
    private:
    string symbol,type;

    public:
    SymbolInfo():symbol(""),type(""){}

    SymbolInfo(string symbol,string type):symbol(symbol),type(type){}

    string getSymbol(){return symbol;}

    string getType(){return type;}

    string setVal(SymbolInfo* sym){
        this->symbol=sym->symbol;
        this->type=sym->type;
    }

    ~SymbolInfo(){}
};

class SymbolTable{
    private:
    SymbolInfo** hash_table;

    public:
    SymbolTable(){
        hash_table = new SymbolInfo*[96];
        for(int i=0;i<96;++i){
            hash_table[i]=new SymbolInfo[1000];
        }
    }

    int getHashIndx(int ascii){return (ascii*91)%96;}

    bool Insert(SymbolInfo* sym){
        int i=getHashIndx((int)(sym->getSymbol()[0]));
        pair<int,int>val=Lookup(sym->getSymbol());
        if(val.first!=-1 && val.second!=-1){
            return 0;
        }
        for(int j=0;j<1000;++j){
            if(hash_table[i][j].getSymbol()==""){
                hash_table[i][j].setVal(sym);
                return 1;
            }
        }
    }
    pair<int,int> Lookup(const string &symbol){
        int i=getHashIndx(symbol[0]);
        for(int j=0;j<1000;++j){
            if(hash_table[i][j].getSymbol()=="")break;
            if(hash_table[i][j].getSymbol()==symbol) return {i,j};
        }
        return {-1,-1};
    }
    void Delete(string &symbol){
        pair<int,int>val=Lookup(symbol);
        int i=val.first,j=val.second;
        if(i!=-1 && j!=-1){
            SymbolInfo* sym=new SymbolInfo();
            hash_table[i][j].setVal(sym);
            for(int k=j+1;j<1000;++k){
                if(hash_table[i][k].getSymbol()=="")break;
                hash_table[i][k-1].setVal(&hash_table[i][k]);
            }
            return;
        }
    }
    void Print(FILE *logout){
        for(int i=0;i<96;++i){
            fprintf(logout,"%d -->",i);
            for(int j=0;j<1000;++j){
                if(hash_table[i][j].getSymbol()=="")break;
                fprintf(logout,"<%s,%s>",hash_table[i][j].getType().c_str(),hash_table[i][j].getSymbol().c_str());
            }
            fprintf(logout,"\n");
        }
    }

    ~SymbolTable(){
        for(int i=0;i<96;++i){
            delete[] hash_table[i];
        }
        delete[] hash_table;
    }
};

