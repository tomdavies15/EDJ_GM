library(Morpho);library(princurve);library(tripack)

fix<-landmark_guide$fixed_landmarks; slider<-landmark_guide$semilandmarks; curves<-landmark_guide$curves

# First sliding step
slid1<-slider3d(dat.array=Landmarks_preslide,SMvector=slider,outlines=curves,iterations = 1, stepsize = 1)

# Project back onto curves
slid1_p<-array(dim=dim(slid1$dataslide))
for(a in 1:length(slid1$dataslide[1,1,])){
  s1_p_E1<-project_to_curve(slid1$dataslide[c(1:(fix[2]-1)),,a],splines$EDJ1[[a]],stretch=0)
  s1_p_E2<-project_to_curve(slid1$dataslide[c(fix[2]:(fix[3]-1)),,a],splines$EDJ2[[a]],stretch=0)
  s1_p_C<-project_to_curve(slid1$dataslide[c(fix[3]:length(slid1$dataslide[,1,1])),,a],splines$CEJ[[a]],stretch=0)
  slid1_p[,,a]<-rbind(s1_p_E1$s,s1_p_E2$s,s1_p_C$s)
  slid1_p[fix,,a]<-slid1$dataslide[c(fix),,a]
}

# Second sliding step
slid2<-slider3d(dat.array=slid1_p,SMvector=slider,outlines=curves,iterations = 1, stepsize = 1)

# Project back onto curves
slid2_p<-array(dim=dim(slid2$dataslide),dimnames = list(NULL,NULL,dimnames(Landmarks_preslide)[[3]]))
for(a in 1:length(slid2$dataslide[1,1,])){
  s2_p_E1<-project_to_curve(slid2$dataslide[c(1:(fix[2]-1)),,a],splines$EDJ1[[a]],stretch=0)
  s2_p_E2<-project_to_curve(slid2$dataslide[c(fix[2]:(fix[3]-1)),,a],splines$EDJ2[[a]],stretch=0)
  s2_p_C<-project_to_curve(slid2$dataslide[c(fix[3]:length(slid2$dataslide[,1,1])),,a],splines$CEJ[[a]],stretch=0)
  slid2_p[,,a]<-rbind(s2_p_E1$s,s2_p_E2$s,s2_p_C$s)
  slid2_p[fix,,a]<-slid2$dataslide[c(fix),,a]
}

# Procrustes registration
Proc<-procSym(dataarray=slid2_p,SMvector=NULL,outlines=curves)

# UP colours
col<-c("#e41a1c","#377eb8","black","#4daf4a","black","#984ea3")
# LP3 colours
col<-c("#e41a1c","black","#377eb8","black","#4daf4a","black","#984ea3")
# LP4 colours
col<-c("#e41a1c","black","black","#377eb8","#4daf4a","#984ea3")

# Plot PCA
plot(cbind(Proc$PCscores[,1],Proc$PCscores[,2]),type="n",asp=1,cex=1,xlab="PC 1",ylab="PC 2")
for(a in 1:length(levels(groups))){
  sub<-groups==levels(groups)[a]
  tr <- NULL
  try(tr<-tri.mesh(x=Proc$PCscores[sub,1],y=Proc$PCscores[sub,2],duplicate = "error"))
  if(!is.null(tr)){
    polygon(convex.hull(tr)$x,convex.hull(tr)$y,col=(adjustcolor(col[a], alpha.f = 0.5)),border=col[a])
  } else if(sum(sub)==2){
    lines(Proc$PCscores[sub,1],Proc$PCscores[sub,2],col=col[a],lwd = 2)
  }}
points(cbind(Proc$PCscores[,1],Proc$PCscores[,2]),col=col[groups],pch=19)
text(cbind(Proc$PCscores[,1],Proc$PCscores[,2]),label=dimnames(Proc$PCscores)[[1]],col=col[groups],pos=c(1,2),cex=0.6,offset=0.5)

#### END
